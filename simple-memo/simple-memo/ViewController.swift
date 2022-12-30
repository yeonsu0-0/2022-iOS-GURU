//
//  ViewController.swift
//  simple-memo
//
//  Created by yeonsu on 2022/12/30.
//

import UIKit
import FMDB

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var databasePath = String()

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func addBtn(_ sender: Any) {
        guard let data = inputField.text
        else {
            return
        }
        taskList.append(data)
        inputField.text = ""
        table.reloadData()
    }
    
    var taskList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        // DB 초기화 함수 호출
        self.initDB()
    }
    
    func initDB() {
        let fileMgr = FileManager.default
        // 접근 경로
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        
        databasePath = docDir + "/memos.db"
        // 파일이 없는 경우
        if !fileMgr.fileExists(atPath: databasePath) {
            // DB 만들기
            let db = FMDatabase(path: databasePath)
            // 테이블 만들기
            if db.open() {
                let query = "create table if not exists memo (task string primary key)"
                // 오류가 발생할 경우
                if !db.executeStatements(query) {
                    NSLog("DB 생성 실패")
                }
                else {
                    NSLog("DB 생성 성공")
                }
            }
        }
        else {  // 파일 있는 경우
            NSLog("DB 파일 존재")
        }
    }
    
    // 데이터베이스에 저장
    @IBAction func doSave(_ sender: Any) {
        print("do Save!")
        let db = FMDatabase(path: databasePath)
        
        if db.open() {
            let insertSql = "INSERT INTO memos values(‘\(taskList)’)"
            let result = db.executeUpdate(insertSql, withArgumentsIn: [])
            if !result {
                print("저장 실패")
            }
        } else {
            print("DB 연결 실패")
        }
    }
    
    // 데이터베이스에서 꺼내오기
    @IBAction func doLoad(_ sender: Any) {
        print("do Load!")
        
        let db = FMDatabase(path: databasePath)
        taskList = Array<String>()
        
        if db.open() {
            let query = "select * from memos"
            // 쿼리 실행
            if let result = db.executeQuery(query, withArgumentsIn: []) {
                
                while result.next() {
                    var columnArray = Array<String>()
                    columnArray.append(result.string(forColumn: "cell") ?? "")
                    taskList.append(String(result.string(forColumn: "cell") ?? ""))
                }
                self.table.reloadData()
            } else {
                NSLog("결과 없음")
            }
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

