//
//  WebtoonCell.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/04.
//

import UIKit


class WebToonCell: UICollectionViewCell {
    
    // Step 3. Custom Cell 구현하기 위해 IBOutlet 연결
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

}

