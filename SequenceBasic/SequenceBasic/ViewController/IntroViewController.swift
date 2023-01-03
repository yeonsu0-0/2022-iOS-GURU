//
//  IntroViewController.swift
//  SequenceBasic
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit
import SwiftyGif

class IntroViewController:UIViewController {
    
    @IBOutlet weak var intro_img:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gif 애니메이션 띄우기
        do {
            let gif = try UIImage(gifName: "rabbit.gif")
            self.intro_img.setGifImage(gif, loopCount: 1)
            self.intro_img.delegate = self
        } catch {
            NSLog("Gif 이미지 불러오기 실패")
        }
        
        /* 로딩이 필요한 정보가 있다면 */
        // 이 때 로드를 완료하고 나서 화면을 전환한다.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 몇 초 후에 화면 전환: 타이머
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            // 1. 스토리보드 존재 유무 확인
                // if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
                // 2. 스토리보드 보이기
                // vc.modalPresentationStyle = .fullScreen
                // self.present(vc, animated: true)
            self.goMainView()
            }
        }
    }


// Gif 한 번 실행 후 멈추기
extension IntroViewController:SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
            print("gifDidStop")
        }
    
    func goMainView() {
        // 1. 스토리보드 존재 유무 확인
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
            // 2. 스토리보드 보이기
             vc.modalPresentationStyle = .fullScreen
             self.present(vc, animated: true)
        }
    }
}
