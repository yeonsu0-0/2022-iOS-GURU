//
//  ViewController.swift
//  TableViewExample
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit

// 1. UITableViewDataSource: numberOfRowsInSection, cellForRowAt 메서드 필수 설정
// 2. UITableViewDelegate: 테이블 뷰에서 section의 header 및 footer를 관리하고, 셀을 삭제하거나 위치를 바꾸는 등 메서드 제공
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var datasource = [1,2,3,4,5]
    
    
    /* numberOfRowsInSection */
    // 한 섹션에 몇 줄이 나올 것인지 설정 (Int값 반환)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    /* cellForRowAt */
    // 해당 줄에 어떤 내용을 넣을 것인지 설정 (Cell 반환)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        cell.textLabel?.text = "\(datasource[row])"
        return cell
    }
    
    /* trailing */
    // 스와이프를 했을 때 셀 오른쪽 끝에 나타날 버튼 지정
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 스와이프 시 삭제 버튼 나타내기
        let deleteBtn = UIContextualAction(style: .destructive, title: "Delete") { [weak self](action, view, completion) in
            /* 버튼 클릭 시 실제로 삭제하기 */
            // 1. 데이터 지우기
            let row = indexPath.row
            self?.datasource.remove(at: row)
            
            // 2. 화면에서 지우기
            tableView.deleteRows(at: [indexPath], with: .fade)  // 지우고 나서 numberOfRowsInSection 값 변경까지 해야 함!
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteBtn])
    }
    
    /* leading */
    // 스와이프를 했을 때 셀 왼쪽 시작 부분에 나타날 버튼 지정
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareBtn = UIContextualAction(style: .normal, title: "Share") { action, view, completion in
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [shareBtn])
    }
    
    /* indexPath에 따라 어떤 줄은 지울 수 있게, 어떤 줄은 지울 수 없게 설정하기 */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let row = indexPath.row
        return row % 2 == 0     // indexPath.row가 홀수일 때만 지울 수 있도록
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
}

