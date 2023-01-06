//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit
import Alamofire
/* Alamore란 iOS, macOS를 위한 Swift 기반의 HTTP 네트워킹 라이브러리 */
import AlamofireImage

class ViewController: UIViewController {
    
    var person_data = [Personinfo]()
    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    
    func getData() {
        print("Start Loading")
        let headers: HTTPHeaders = [
            "app-id": "63b79f2d4809b962cfec14c3"    // id
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
                    self.person_data = dummy_data.data
                    self.personCollectionView.reloadData()
                    print(dummy_data)      // finish parsing(비동기)
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
    
    //
    // indexPathsForSelectedItems
    // cell 선택 시 상세 화면 띄우기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(self.personCollectionView.indexPathsForSelectedItems)
        if let indexPath = self.personCollectionView.indexPathsForSelectedItems?.first {
            let person_info = person_data[indexPath.row]
            print(person_info.id)
            if let vc = segue.destination as? DetailController {
                vc.user_id = person_info.id
            }
        }
    }
    //
}


/* API 내용 보이기 */
// 1. Storyboard에서 CollectionView 생성 후 Cell에 Object 추가 - Cell Identifier 설정
// 2. personCell 생성 후 @IBOutlet 연결, Cell에 Class 연결
// 3. Collection View에 dataSource 연결

// 4. UICollectionViewDataSource 채택해서 필수 메서드 numberOfItemsInSection, cellForItemAt 구현
extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person_data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        
        let data = person_data[indexPath.row]

        // cell 디자인
        cell.idLabel.text = data.id
        cell.nameLabel.text =  data.firstName + " " + data.lastName
        // cell.profileImage.image = UIImage(named: "person")
        if let url = data.picture {
            cell.profileImage.af.setImage(withURL: url)
        }

        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 16
        return cell
    }
}

// 5. Collection View에 dataDelegate 연결 후 사이즈 설정
extension ViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width
        let height = width/4
        return CGSize(width: width, height: height)
    }
}



// ================ < cell 선택 시 상세 화면 띄우기 > ================
// 1. 리스트 view에서 Navigation Controller 설정
// 2. 리스트 view의 cell - 새로운 view로 연결(show): back 버튼 생성



extension ViewController:UICollectionViewDelegate {
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        print(person_data[indexPath.row])
    }
    */
}
