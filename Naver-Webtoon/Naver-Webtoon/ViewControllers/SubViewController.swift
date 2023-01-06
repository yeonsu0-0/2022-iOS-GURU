//
//  SubViewController.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/06.
//

import UIKit

class SubViewController:ViewController {
    var webtoonInfo:WebToonData!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var authors: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titles.text = "팔이피플"
        self.authors.text = "매미/희세"
        self.images.image = UIImage(named: "title01")
    }
}
