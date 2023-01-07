//
//  ViewController.swift
//  Playlist
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var datasource:[String] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! musicCell

        let row = indexPath.row
        cell.musicLabel.text = "\(datasource[row])"
        
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
            // tableView.deleteRows(at: [indexPath], with: .fade)  // 지우고 나서 numberOfRowsInSection 값 변경까지 해야 함!
            tableView.reloadData()
            self?.saveData()
            completion(true)
        }
        
        // 스와이프 시 수정 버튼 나타내기
        let editBtn = UIContextualAction(style: .normal, title: "Edit") { [weak self](action, view, completion) in
            
            // 1. [Edit]버튼 누르면 Alert창 나오는 변수 선언
            let editAlert = UIAlertController(title: "Edit playlist", message: "Change your playlist", preferredStyle: .alert)
            
            // 2. Alert창에 textField 추가하고, cell의 텍스트값 불러오기
            editAlert.addTextField { (textField) in
                textField.text = self?.datasource[indexPath.row]
            }
            
            // 3. [수정]버튼 생성 및 수정 액션 할당
            editAlert.addAction(UIAlertAction(title: "Modify", style: .default, handler: { (action) in
                if let fields = editAlert.textFields,
                   let textField = fields.first,
                   let text = textField.text {
                    self?.datasource[indexPath.row] = text
                    // self?.tableView.reloadData()
                    self?.tableView.reloadRows(at: [indexPath], with: .fade)
                    self?.saveData()
                }
            }))
            
            // 4. [취소]버튼 생성
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self!.present(editAlert, animated: true, completion: nil)
            completion(true)
        }
        
        
        deleteBtn.backgroundColor = UIColor.red     // 버튼 컬러 변경
        editBtn.backgroundColor = UIColor.blue
        return UISwipeActionsConfiguration(actions: [deleteBtn, editBtn])
        }
    
    
    /* leading */
    // 스와이프를 했을 때 셀 왼쪽 시작 부분에 나타날 버튼 지정
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareBtn = UIContextualAction(style: .normal, title: "Share") { action, view, completion in
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [shareBtn])
    }
    
    
 
        

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* UIRefreshControl: 테이블 뷰를 아래로 당기면 새로고침 */
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        
        // UserDefault에서 저장된 값 불러오기
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "ListData") as? [String] {
            print(value, "from UserDefaults")
            self.datasource = value
        }
    }
    @objc func fetchData(_ sender:Any) {
        tableView.refreshControl?.endRefreshing()
    }
    
    /* indexPath에 따라 어떤 줄은 지울 수 있게, 어떤 줄은 지울 수 없게 설정하기 */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let row = indexPath.row
        return true     // indexPath.row가 홀수일 때만 지울 수 있도록
    }
    
    // ================================================================
    // cell 앞에 삭제 아이콘 버튼⛔️이 생성됨
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // cell 뒤에 순서 변경 버튼이 생성됨
    // 겉보기로만 바뀐 상태: 다시 앱을 키면 원상복구됨
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to
                   destinationIndexPath: IndexPath) {
        // 빼서 집어넣기
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        let data = datasource[fromRow]
        datasource.remove(at: fromRow)
        datasource.insert(data, at: toRow)
        saveData()
        tableView.reloadData()
    }
    
    
    
    // 추가 버튼 메서드
    @IBAction func addPlaylist(_ sender: UIButton) {
        // print(memoText.text)     항상 잘 실행되는지 확인하는 습관 기르기
        
        // 옵셔널 언래핑
        guard let list = textField.text, list != "" else {
            return
        }
        // print(memo)
        //  ============ < 변수에 저장하기 > ============
        self.datasource.append(list)    // 데이터 추가
        textField.text = ""              // 텍스트 필드 초기화
        self.saveData()
        self.tableView.reloadData()     // 테이블뷰 갱신
    }
    
    
    // ======== < UserDefaults에 저장하기 > ========
func saveData() {
    print("save!")
    let userDefault = UserDefaults.standard
    userDefault.setValue(datasource, forKey: "ListData")
    userDefault.synchronize()
}
    // cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 12
    }

}

