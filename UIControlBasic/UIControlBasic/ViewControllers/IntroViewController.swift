//
//  IntroViewController.swift
//  UIControlBasic
//
//  Created by yeonsu on 2023/01/10.
//

import UIKit
import SwiftyGif

class IntroViewController:UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    // Gif 이미지 띄우기
    override func viewDidLoad() {

        do {
            let gif = try UIImage(gifName: "nyanCat.gif")
            self.logoImageView.setGifImage(gif, loopCount: -1)
        } catch {
            NSLog("Error!")
        }
    }
    
    // 메인 View로 이동
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NSLog("Before Timer")
        // 타이머 설정
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView") {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
