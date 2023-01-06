//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit
import Alamofire
/* Alamore란 iOS, macOS를 위한 Swift 기반의 HTTP 네트워킹 라이브러리 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    
    func getData() {
        print("Start Loading")
        let headers: HTTPHeaders = [
            "app-id": "id"    // id
        ]
        
        // API request
        AF.request("https://dummyapi.io/data/v1/user?limit=10", headers: headers).responseJSON {
            response in
            // debugPrint(response)     : - 무조건 출력
            // print(response.result)   : success
            
            // data parsing
            switch response.result {
            case.success(let data):
                print(data)
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let dummy_data = try decoder.decode(DummyData.self, from: jsonData)
                    print(dummy_data)      // finish parsing
                } catch {
                    debugPrint("error")
                }
            case.failure(let data):
                print("fail")
            default:
                return
            }
            
        }
        print("Finish Loading")
    }

}

