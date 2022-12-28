//
//  ViewController.swift
//  Lotto-draw
//
//  Created by yeonsu on 2022/12/28.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    var lottoNumbers = Array<Array<Int>>()
    var databasePath = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    // 화면이 로드 된 다음에 무엇을 할 것인지 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        // 데이터베이스 초기화
        // create table
        
        // CoreData, SQLite3(경량 데이터베이스),...
        /* 앱을 처음 실행했을 때 프로세스
         - 앱에서 접근 가능한 데이터베이스 파일 생성
         - 생성된 파일에 테이블 생성 */
        
        // DB 초기화 함수 호출
        self.initDB()
    }
    
    func initDB() {
        let fileMgr = FileManager.default
        // 접근 경로
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        
        databasePath = docDir + "/lotto.db"
        // 파일이 없는 경우
        if !fileMgr.fileExists(atPath: databasePath) {
            // DB 만들기
            let db = FMDatabase(path: databasePath)
            // 테이블 만들기
            if db.open() {
                let query = "create table if not exists lotto (id integer primary key autoincrement, num1 integer, num2 integer, num3 integer, num4 integer, num5 integer, num6 integer)"
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
    
    // 데이터베이스에서 꺼내오기
    @IBAction func doLoad(_ sender: Any) {
        print("do Load!")
        lottoNumbers = Array<Array<Int>>()
        let db = FMDatabase(path: databasePath)
        if db.open() {
            let query = "select * from lotto"
            // 쿼리 실행
            if let result = db.executeQuery(query, withArgumentsIn: []) {   // NULL이 아닌 경우
                while result.next() {
                    var columnArray = Array<Int>()
                    columnArray.append(Int(result.int(forColumn: "num1")))
                    columnArray.append(Int(result.int(forColumn: "num2")))
                    columnArray.append(Int(result.int(forColumn: "num3")))
                    columnArray.append(Int(result.int(forColumn: "num4")))
                    columnArray.append(Int(result.int(forColumn: "num5")))
                    columnArray.append(Int(result.int(forColumn: "num6")))
                    
                    lottoNumbers.append(columnArray)
                }
                self.tableView.reloadData()
            } else {
                NSLog("결과 없음")
            }
        } else {
            NSLog("DB 연결 실패")
        }
    }
    
    
    
    
    // 로또 랜덤 숫자 만들기
    @IBAction func doDraw(_ sender: Any) {
        print("do Draw!")
        lottoNumbers = Array<Array<Int>>()
        var originalNumbers = Array(1...45)
        var index = 0
        
        for _ in 0...4 {    // 5줄
            originalNumbers = Array(1...45)
            var columnArray = Array<Int>()
            
            for _ in 0...5 {    // 1줄에 6개의 번호
                index = Int.random(in: 0..<originalNumbers.count)   // 1 ~ 45 중  숫자 하나 뽑기
                columnArray.append(originalNumbers[index])  // 뽑은 숫자를 배열에 저장
                originalNumbers.remove(at: index)   // 뽑힌 숫자 제거(중복 방지)
            }//end for _ in 0...5
            columnArray.sort()
            lottoNumbers.append(columnArray)    // 6개의 번호를 한 줄에 저장
        }   // end for _ in 0...4
        self.tableView.reloadData()     // 새로 로드하여 데이터 보여주기
    }
    
    
    // 데이터베이스에 저장
    @IBAction func doSave(_ sender: Any) {
        print("do Save!")
        let db = FMDatabase(path: databasePath)
        if db.open() {
            try! db.executeUpdate("delete from lotto", values: [])
            for numbers in lottoNumbers {
                let query = "insert into lotto(num1, num2, num3, num4, num5, num6) values (\(numbers[0]), \(numbers[1]), \(numbers[2]), \(numbers[3]), \(numbers[4]), \(numbers[5]))"
                if !db.executeUpdate(query, withArgumentsIn: []) {
                    NSLog("저장 실패")
                } else {
                    NSLog("저장 성공")
                }
            }
        } else {
            NSLog("DB 연결 실패")
        }
    }
}


// 테이블뷰 구현을 귀한 필수 메서드
// extension은 변수 선언 불가능, 메서드만 가능

extension ViewController:UITableViewDataSource {
    // cell의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lottoNumbers.count
    }
    
    // cell에 내용을 넣어서 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell의 Identifier는 스토리보드-lottoCell에서 설정한 Identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for: indexPath) as! LottoCell
        let numbers = self.lottoNumbers[indexPath.row]
        cell.label01.text = "\(numbers[0])"
        cell.label02.text = "\(numbers[1])"
        cell.label03.text = "\(numbers[2])"
        cell.label04.text = "\(numbers[3])"
        cell.label05.text = "\(numbers[4])"
        cell.label06.text = "\(numbers[5])"

        return cell
    }
}
