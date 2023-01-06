//
//  DailyWebtoonListViewController.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit
import Parchment     // cocoapod 'Parchment' 설치 후 진행

// Step 9. 요일별 pagination
class DailyWebtoonListViewController:UIViewController {
    
    var pagingViewController:PagingViewController!
    var viewControllers:[ViewController] = []
    let dayTitles = ["월", "화", "수", "목", "금", "토", "일"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let firstViewController = UIViewController()
        firstViewController.title = "A"
        let secondViewController = UIViewController()
        secondViewController.title = "B"
        
        pagingViewController = PagingViewController(viewControllers: [
          firstViewController,
          secondViewController
        ])
         */
        
        for title in dayTitles {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "webtoonListView") as? ViewController {
                vc.title = title
                viewControllers.append(vc)
            }
        }
        pagingViewController = PagingViewController(viewControllers:viewControllers)
        pagingViewController.menuItemSize = .fixed(width: 58, height: 40)
        pagingViewController.menuItemSpacing = 0 
        pagingViewController.indicatorColor = UIColor(red: 5/255, green: 214/255, blue: 134/255, alpha: 1)
    }
    
    // Step 9-1. 하위 뷰가 다 불러와지면 뷰 추가
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addChild(pagingViewController)
        pagingViewController.view.frame = self.view.frame
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
}
