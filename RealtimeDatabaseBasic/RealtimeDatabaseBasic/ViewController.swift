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
        self.ref.child("users/123456/username").setValue(["test":"apple"])  // 하위 데이터로 새로 생성
        
        // updateChildValues: 기존 데이터 수정
        self.ref.child("users/123456/username").updateChildValues(["test":"banana"])  //
        NSLog("2")  // 비동기
        
        ref2 = ref.child("users/2468")
        
    // observe: 값이 바뀌면 전체 데이터를 다 읽어들인다.
        refHandle = ref.observe(DataEventType.value, with: { snapshot in
            let postDict = snapshot.value as? [String: AnyObject] ?? [:]
            print(postDict)
        })
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
    
}

