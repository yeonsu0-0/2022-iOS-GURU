//
//  WebtoonData.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/04.
//

import Foundation


// Step 5. 구조체로 데이터 생성
struct WebToonData {
    var title_image:String!
    var title:String!
    var rating:Float!
    var author:String!
    
    // 초기화
    init (_ title:String, _ title_image: String, _ rating:Float, _ author: String) {
        self.title = title
        self.title_image = title_image
        self.rating = rating
        self.author = author
    }
}
