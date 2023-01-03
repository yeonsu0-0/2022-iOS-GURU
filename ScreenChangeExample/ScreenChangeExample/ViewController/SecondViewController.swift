//
//  SecondViewController.swift
//  ScreenChangeExample
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit

class SecndViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // segue를 이용해서 다른 화면으로 넘어가기 직전 실행되는 메서드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("prepare segue")
        
        if let destination = segue.destination as? ThirdViewController {
            // 에러! 변수는 존재하지만 화면이 뜨기 전이라 UI가 없는 상태기 때문
            // destination.label.text = "test!"
            destination.labelText = "test!"
        }
    }
}
