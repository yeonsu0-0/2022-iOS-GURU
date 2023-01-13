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
    let imagePicker = UIImagePickerController()
    var file_name:String!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = storage.reference()

    }
    
    /* 분할 정복 */
    // 어떤 기능을 구현하고 싶다
    // 기능을 세분화해서 단계를 나눈다
    
    @IBAction func selectImage(_ sender: Any) {
        
        // ========= [Select Image] - Action Sheet 띄우기 =========
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
                self.showGallery()
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
    
    // ========= 업로드 버튼 =========
    @IBAction func uploadImage(_ sender: UIButton) {
        print("upload btn pressed")
        guard let image = imageView.image else {
            print("이미지 없음")     // 이미지 선택 X
            let alertVC = UIAlertController(title: "알림", message: "이미지를 선택하고 업로드 기능을 실행하세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        print("이미지 있음") // 이미지 선택 O
        
        // 메모리에서 데이터(사진) 업로드하기
        if let data = image.pngData() {
            // debugPrint(data)
            let imageRef = storageRef.child("images/\(file_name!).png")  // 파일명 가져오기
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"  // 이미지 확장자 변경
            
            let uploadTask = imageRef.putData(data, metadata: metadata) { (metadata, error) in
              guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
              }
              // Metadata contains file metadata such as size, content-type.
              let size = metadata.size
              // You can also access to download URL after upload.
                imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  return
                }
                print(downloadURL, "upload complete")
              }
            }
        }
        
    }
    // ============================
    
}


// ImagePicker
extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func showGallery() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary  // 갤러리 접근
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 이미지를 고른 뒤 할 일
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)    // 선택한 뒤 이미지 피커 사라지게 함
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        // 파일명 얻어오기
        if let url = info[.imageURL] as? URL {
            file_name = (url.lastPathComponent as NSString).deletingPathExtension
            print(file_name, "- file name")
        }
        imageView.image = selectedImage     // 이미지 뷰에 띄우기
    }
}
