//
//  ViewController.swift
//  FireStorageBasic
//
//  Created by yeonsu on 2023/01/12.
//

import UIKit
import FirebaseStorage
import Photos

class ViewController: UIViewController {

    let storage = Storage.storage()     // storage 연결
    var storageRef:StorageReference!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = storage.reference()

    }
    
    /* 분할 정복 */
    // 어떤 기능을 구현하고 싶다
    // 기능을 세분화해서 단계를 나눈다
    
    @IBAction func selectImage(_ sender: Any) {
        
        // ========= Action Sheet 띄우기 =========
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)     // 화면
        // Cancel 버튼 추가
        let action_cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)    // 액션
        actionSheet.addAction(action_cancel)
        //
        
        // 갤러리 버튼 추가
        let action_gallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
            print("갤러리 버튼 선택")
            switch PHPhotoLibrary.authorizationStatus() {   // 갤러리 접근 권한 확인
            case .authorized:
                print("접근 가능")  // 권한O  //Info.plist에서 설정
            case.notDetermined:
                print("권한 요청한 적 없음")    // 권한X
                
                // 권한 요청
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
                    switch status {
                    case.authorized:    // 권한 허용
                        print("허용")
                        /*
                        let alertVC = UIAlertController(title: "권한 확인", message: "접근 권한 생성이 완료되었습니다. 갤러리 버튼을 다시 눌러주세요", preferredStyle: .alert) // 알림창
                        let cancelBtn = UIAlertAction(title: "OK", style: .default)
                        alertVC.addAction(cancelBtn)
                        self.present(alertVC, animated: true, completion: nil)
                         */
                    default:    // 권한 거절
                        print("허용하지 않음")
                    }
                }
            default:
                print("권한 없음")
                let alertVC = UIAlertController(title: "권한 필요", message: "갤러리 접근 권한이 필요합니다. 설정 화면에서 설정해주세요", preferredStyle: .alert) // 알림창
                let action_settings = UIAlertAction(title: "Go Settings", style: .default) { (action) in
                    print("go settings")
                    // Settings(다른 어플리케이션)으로 가기
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                    }
                    
                }
                let action_cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertVC.addAction(action_settings)
                alertVC.addAction(action_cancel)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        actionSheet.addAction(action_gallery)
        //
        present(actionSheet, animated: true, completion: nil)
        // ======================================
        
        
    }
}

