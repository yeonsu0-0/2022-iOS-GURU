//
//  ViewController.swift
//  RealtimeDatabaseBasic
//
//  Created by yeonsu on 2023/01/12.
//

import UIKit
import FirebaseDatabase

/*
 FMDB 프로세스
 1. DB가 저장될 파일을 만든다.
 2. DB에 연결한다.
 3. DB를 초기화한다.
 4. DB 명령어를 수행한다. (추가, 수정, 삭제)
 */

class ViewController: UIViewController {
    
    var ref: DatabaseReference!     // 데이터베이스 연결할 변수
    var ref2: DatabaseReference!     // 데이터베이스 연결할 변수
    var refHandle: DatabaseHandle!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        NSLog("1")

        // 키 값 새로 발급
        // 추가 정보 관리할 때 등
        guard let key = ref.child("posts").childByAutoId().key else { return }
        let post = ["uid": "rabbit",
                    "author": "Bonny",
                    "title": "Title"
                    ] // 더미 데이터
        
        let childUpdates = ["/posts/\(key)": post,
                            "/user-posts/rabbit/posts/\(key)/": post]
        
        ref.updateChildValues(childUpdates)
        
        /*
         
        // setValue로 데이터 쓰기
        // 데이터 새로 생성
        self.ref.child("users/\(key)").setValue(
            ["dinner":"meat", "drink":"coke", "date":Date().timeIntervalSince1970]) {
            
            /* Add a Completion Block */
            // If you want to know when your data has been committed, you can add a completion block.
            (error:Error?, ref:DatabaseReference) in
             if let error = error {
               print("Data could not be saved: \(error).")
             } else {
                 // 알림창 띄우기
                 let alertVC = UIAlertController(title: "완료", message: "Data saved!!", preferredStyle: .alert)
                 alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                 self.present(alertVC, animated: true, completion: nil)
                print("Data saved successfully!")
             }
        }
       
         */
        
        // updateChildValues: 기존 데이터 수정
        self.ref.child("users/123456/username").updateChildValues(["test":"banana"])  //
        NSLog("2")  // 비동기
        
        ref2 = ref.child("users/2468")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("옵저버 등록")
        
    /* 옵저버 설정 */
    // 값이 바뀌면 전체 데이터를 다 읽어들인다.
        refHandle = ref.observe(DataEventType.value, with: { snapshot in
            let postDict = snapshot.value as? [String: AnyObject] ?? [:]
            print(postDict)
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("옵저버 삭제")
        
    /* 옵저버 분리 */
    // 화면이 사라지면 옵저버를 삭제한다.
        ref2.removeObserver(withHandle: refHandle)
    }
    
    // observeSingleEvent: 어떤 액션을 취했을 때 혹은 어떤 순간만 딱 한 번 데이터를 불러온다.
    // 한 번만 로드하면 되고, 자주 변경되거나 적극적인 수신이 필요하지 않은 데이터에 유용
    @IBAction func pressBtn(_ sender: UIButton) {
        NSLog("Button Pressed!")
        ref2.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? [String:AnyObject] ?? [:]
            print(data)
        }
    }
    
    // removeValue: 데이터 삭제
    @IBAction func removeData(_ sender: Any) {
        NSLog("remove btn pressed!")
        self.ref.child("users/123456/username").removeValue() {
            
            /* Add a Completion Block */
            // If you want to know when your data has been committed, you can add a completion block.
            // 알림창 띄우기
            (error:Error?, ref:DatabaseReference) in
             if let error = error {
               print("Data could not be saved: \(error).")
             } else {
                 let alertVC = UIAlertController(title: "완료", message: "Remove Data!!", preferredStyle: .alert)
                 alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                 self.present(alertVC, animated: true, completion: nil)
                print("Data saved successfully!")
             }
        }
    }
    
    
}

