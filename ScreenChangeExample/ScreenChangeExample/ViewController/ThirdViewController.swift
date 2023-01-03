//
//  ThirdViewController.swift
//  ScreenChangeExample
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Third View Init")
    }
    
    // second -> third 뷰로 바꿀 때 label 바꾸기
    @IBOutlet weak var label: UILabel!
    
    var labelText = ""
    
    // 화면을 전환할 때마다 view stack이 쌓임 -> back 버튼 누르면 stack 제거
    @IBAction func goBack(_ sender: Any) {
        NSLog("Back Btn")
        
        // 현재 화면을 띄워준 부모 뷰가 있는지 확인
        if let preVC = self.presentingViewController as? UIViewController {
            // 현재 화면 없애기
            preVC.dismiss(animated: false, completion: nil)
        }
    }
    
    // view가 나타났을 때 label 변경하기
    // 화면이 완전히 나타났을 때
    override func viewDidAppear(_ animated: Bool) {
        // self.label.text = self.labelText
    }
    
    // 화면이 나타나려고 할 때
    override func viewWillAppear(_ animated: Bool) {
        self.label.text = self.labelText
    }
}
