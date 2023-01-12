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
        
        // setValue로 데이터 쓰기
        // 데이터 새로 생성
        self.ref.child("users/123456/username").setValue("yeonsu")
        self.ref.child("users/123456/username").setValue(["test":"apple"]) {  // 하위 데이터로 새로 생성
            
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
        
        // updateChildValues: 기존 데이터 수정
        self.ref.child("users/123456/username").updateChildValues(["test":"banana"])  //
        NSLog("2")  // 비동기
        
        ref2 = ref.child("users/2468")
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

