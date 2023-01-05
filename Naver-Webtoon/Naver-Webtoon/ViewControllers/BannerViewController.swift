//
//  BannerViewController.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit

class BannerViewController:UIViewController {

    let banner_images = ["banner01", "banner02", "banner03", "banner04"] 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // ============= Step 8. Banner 설정 =============
        
        // width : height = 218 : 120
        // width * 120 = height * 180
        // height = width * 120 / 218
        let screenSize = UIScreen.main.bounds   // 화면의 크기
        let width = screenSize.width
        let height = width * 120 / 218
        
        for (index, imageName) in banner_images.enumerated() {
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: CGFloat(index)*width, y: 0, width: width, height: height)
            self.view.addSubview(imageView)
        }
        
        self.view.frame = CGRect(x: 0, y: 0, width: width*CGFloat(banner_images.count), height: height)
        
        // ===============================================
    }
}
