//
//  ViewController.swift
//  NavigationBarBasic
//
//  Created by yeonsu on 2023/01/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /* 📌 네비게이션 바 숨기기: 생명주기 별로 설정 */
    override func viewWillAppear(_ animated: Bool) {
        // 네비게이션 바 숨기기(Main, second 둘 다 사라짐)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        // 네비게이션 바 숨기기(Main만 사라지고 second는 보임)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // 네비게이션 바 뒤로가기 버튼 옆 텍스트 숨기기
        self.navigationItem.title = ""
    }
}

