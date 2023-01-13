//
//  ViewController.swift
//  simple-memo
//
//  Created by yeonsu on 2022/12/30.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let database =  Firestore.firestore()
    var text2: String!

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var inputField: UITextField!
    
    // 추가하기
    @IBAction func addBtn(_ sender: Any) {
        guard let data = inputField.text
           else { return }
           taskList.append(data)
           text2 = inputField.text
           inputField.text = ""
           writeData(text: text2 ?? "텍스트 못 읽음")
           table.reloadData()
    }
    
    var taskList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
    }
    
    func writeData(text: String) {
        let docRef = database.document("/post/example")
        docRef.setData(["text": text])
        table.reloadData()
    }

    // 데이터베이스에 저장
    @IBAction func doSave(_ sender: UIButton!) {
        writeData(text: text2 ?? "데이터 없음")
        print("저장됨")
    }
    
    // 데이터베이스에서 꺼내오기
    @IBAction func doLoad(_ sender: Any) {
        let docRef = database.document("/post/example")
        docRef.getDocument { (snapshot, error) in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            print(data)
        }
    }

    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        cell.textLabel?.text = taskList[indexPath.row]
        return cell
    }

}

