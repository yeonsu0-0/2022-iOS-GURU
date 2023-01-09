//
//  ViewController.swift
//  UIControlBasic
//
//  Created by yeonsu on 2023/01/09.
//

import UIKit

class ViewController: UIViewController {

    /* Tab Bar 커스텀 이미지 넣기 */
    // 1. Main StoryBoard에 이미지 뷰 넣고 3개 다 IBOutlet 연결
    // 2. Image View - [Attribute inspector] - tag로 index 설정
    @IBOutlet var tabButtons: [UIImageView]!
    
    @IBOutlet weak var tabStackView: UIStackView!
    
    // 3.
    var viewControllers = [UIViewController]()
    
    // 6. 각각 개별 StoryBoard View를 Main으로 읽어오기
    // StoryBoard 파일명
    // ViewController의 Storyboard ID
    
    static let firstViewController = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "firstView")
    
    static let secondViewController = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "secondView")
    
    static let thirdViewController = UIStoryboard(name: "Third", bundle: nil).instantiateViewController(withIdentifier: "ThirdView")
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // 4. Tab Recognizer 설정
        for btn in tabButtons {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
            // 원래 이미지 뷰는 터치 인식 X -> 인식 되도록 설정
            btn.isUserInteractionEnabled = true
            btn.addGestureRecognizer(tap)
        }
        
    // 7.
        viewControllers.append(ViewController.firstViewController)
        viewControllers.append(ViewController.secondViewController)
        viewControllers.append(ViewController.thirdViewController)
        
    // 8. 현재 display될 화면 설정
        let currentVC = viewControllers[0]
        currentVC.view.frame = UIApplication.shared.windows[0].frame
        // 관계 설정
        currentVC.didMove(toParent: self)
        self.addChild(currentVC)
        //
        // 화면 띄우기
        self.view.addSubview(currentVC.view)
        // 뒤 쪽에 감춰져있는 StackView 앞으로 꺼내기
        self.view.bringSubviewToFront(tabStackView)
    }
    //
    
    // 5. tabTapped() 메서드 구현
    // Tab Menu 터치 시 화면 전환
    @objc func tabTapped(_ sender: UITapGestureRecognizer) {
        NSLog("탭!")
        NSLog("\(sender.view?.tag)")    // 누가 터치했는지 확인
    }

}

