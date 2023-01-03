//
//  IntroViewController.swift
//  ScreenChangeExample
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit

class IntroViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("view appear")
        
        // 코드를 작성해서 화면 넘기는 방법
        // 1. 스토리보드 불러오기
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "firstScreen")
            // 2. 화면 띄우기
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
