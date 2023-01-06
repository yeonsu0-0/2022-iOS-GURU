//
//  DetailController.swift
//  AlamofireBasic
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit
import Alamofire
import AlamofireImage


/* 리스트의 Cell 클릭 시 상세 페이지 나타내기 */
class DetailController:UIViewController {
    
    var user_id:String!
    var user_info:PersonDetail!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var registerdateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(user_id)
    }
    
    func getData(_ user_id:String) {
        print("Start Loading")
        let headers: HTTPHeaders = [
            "app-id": "63b79f2d4809b962cfec14c3"    // id
        ]
        
        // API request
        AF.request("https://dummyapi.io/data/v1/user/\(user_id)", headers: headers).responseJSON {
            response in
            // debugPrint(response)     : - 무조건 출력
            // print(response.result)   : success
            
            // data parsing
            switch response.result {
            case.success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    
                    self.user_info = try decoder.decode(PersonDetail.self, from: jsonData)
                    self.updateInfo()
                    // self.person_data = dummy_data.data
                    // self.personCollectionView.reloadData()
                    // print(dummy_data)      // finish parsing(비동기)
                    print(data)
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
    
    
    func updateInfo() {
        print("update info", user_info)
        
        // 정보 가져오기
        idLabel.text = user_info.id
        nameLabel.text = "\(user_info.firstName) \(user_info.lastName)"
        genderLabel.text = user_info.gender
        registerdateLabel.text = user_info.registerDate
        emailLabel.text = user_info.email
        phoneLabel.text = user_info.phone
        if let address = user_info.location {
            addressLabel.text = "\(address.street), \(address.city), \(address.country)"
        }

        // 이미지 불러오기
        profileImage.af.setImage(withURL: user_info.picture)
    }
}
