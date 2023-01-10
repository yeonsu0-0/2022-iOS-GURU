//
//  ViewController.swift
//  UIControlBasic
//
//  Created by yeonsu on 2023/01/09.
//

import UIKit

class ViewController: UIViewController {
    
    var previousIndex:Int = 0
    var selectedIndex:Int = 0
    
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
        //NSLog("\(sender.view?.tag)")    // 누가 터치했는지 확인
        
        
        // 9. 탭한 화면으로 바꾸기
        if let tag = sender.view?.tag {
            previousIndex = selectedIndex   // 이전 뷰
            selectedIndex = tag     // 새로 선택한 뷰
            
            // ============ < 이전 뷰 빼기 > ============
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: self)
            previousVC.view.removeFromSuperview()   // 슈퍼뷰로부터 제거
            previousVC.removeFromParent()   // 관계 제거
            
            // ============ < 현재 뷰 올리기 > ============
            let currentVC = viewControllers[selectedIndex]
            currentVC.view.frame = UIApplication.shared.windows[0].frame    // 화면 크기 잡기
            currentVC.didMove(toParent: self)
            self.addChild(currentVC)
            self.view.addSubview(currentVC.view)
            
            // ============ < 탭 뷰 올리기 > ============
            self.view.bringSubviewToFront(tabStackView)
        }
    }

}

