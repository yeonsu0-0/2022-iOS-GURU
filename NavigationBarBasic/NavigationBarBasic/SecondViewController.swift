//
//  SecondViewController.swift
//  NavigationBarBasic
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit

class SecondViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Second 뷰의 네비게이션 바 타이틀 설정
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Test2"
    }
}
