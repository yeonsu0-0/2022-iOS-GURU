//
//  WebtoonMainViewController.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/04.
//

import UIKit

class WebtoonMainViewController: UIViewController {
    
    
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 7. bannerScrollView에 Controller 연결
        let bannerViewController = BannerViewController()
        // 화면에 표시
        bannerScrollView.addSubview(bannerViewController.view)
        // 스크롤 가능하도록 컨텐츠 사이즈 설정
        bannerScrollView.contentSize = bannerViewController.view.frame.size
    }
}

