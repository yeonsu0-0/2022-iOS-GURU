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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var memoText: UITextField!
    
    // 변수 초기화
    var datasource:[String] = []
    // 또는 var datasource = [String]()
    
    
    /* numberOfRowsInSection */
    // 한 섹션에 몇 줄이 나올 것인지 설정 (Int값 반환)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    /* cellForRowAt */
    // 해당 줄에 어떤 내용을 넣을 것인지 설정 (Cell 반환)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Basic Cell */
        // let cell = UITableViewCell()
        // cell.textLabel?.text = "\(datasource[row])"
        
        /* Custom Cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! memoCell
        // withIdentifier는 [attribute inspectors] - [Identifier] 설정 값임을 유의히기!
        
        let row = indexPath.row
        cell.memoLabel.text = "\(datasource[row])"
        cell.numLabel.text = "\(row+1)"
        
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
            let editAlert = UIAlertController(title: "Edit Memo", message: "Change your memo", preferredStyle: .alert)
            
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
    
    
 

    override func viewDidLoad() {
        // 뷰 인스턴스가 메모리에 올라왔으나 아직 화면은 뜨지 않은 상황
        super.viewDidLoad()
        // 테이블 자체가 편집이 가능한 상태
        // self.tableView.isEditing = true
    
// ========================================================
        /* UIRefreshControl: 테이블 뷰를 아래로 당기면 새로고침 */
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        
        // UserDefault에서 저장된 값 불러오기
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "MemoData") as? [String] {
            print(value, "from UserDefaults")
            self.datasource = value
        }
    }
    
    @objc func fetchData(_ sender:Any) {
        tableView.refreshControl?.endRefreshing()
    }
    
    
// ========================================================
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
    
    // cell 앞에 버튼 없애기
    /*
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // cell 앞에 버튼 없앴을 때 indent된 부분 없애기
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    */
    
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

    
    
    /* 테이블 뷰 Editing Mode를 껐다 켰다 할 수 있는 버튼 생성 메서드*/
    @IBAction func changeEditing(_ sender: Any) {
        /*
        if self.tableView.isEditing {
            self.tableView.isEditing = false
        } else {
            self.tableView.isEditing = true
        }
        */
        
        // 또는
        self.tableView.isEditing.toggle()
    }   
    
    
    // didSelectRowAt: cell 선택 시 화면 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("selected")
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    
    // 나타나기 직전
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)    // 메인화면이 뜰 때 네비게이션 바 숨기기
    }
    
    
    // 사라지기 직전
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)   // 메인화면이 사라질 때 네비게이션 바 보이기
    }
    
    
    // 추가 버튼 메서드
    @IBAction func addMemo(_ sender: UIButton) {
        // print(memoText.text)     항상 잘 실행되는지 확인하는 습관 기르기
        
        // 옵셔널 언래핑
        guard let memo = memoText.text, memo != "" else {
            return
        }
        // print(memo)
        //  ============ < 변수에 저장하기 > ============
        self.datasource.append(memo)    // 데이터 추가
        memoText.text = ""              // 텍스트 필드 초기화
        self.saveData()
        self.tableView.reloadData()     // 테이블뷰 갱신
        
        /*
         
        // ======== < UserDefaults에 저장하기 > ========
        // 1. UserDefault 인스턴스 생성
        let userDefault = UserDefaults.standard
        // 2. 저장하기
        userDefault.setValue("test", forKey: "Test")
        // 3. *동기화하기(다른 페이지에서 저장된 내용을 바로 호출할 수 있음)
        userDefault.synchronize()
        // 4. viewDidLoad()에서 값 불러오기
        self.tableView.reloadData()
         
         */
    }
        
        // ======== < UserDefaults에 저장하기 > ========
    func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(datasource, forKey: "MemoData")
        userDefault.synchronize()
    }
    
    
    // cell 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 12
    }
    
}

