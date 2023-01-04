//
//  ViewController.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


// Step 1. UICollectionViewDataSource를 상속시켜서 numberOfItemsInSection, cellForItemAt 구현
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webToonCell", for: indexPath)
        // TODO : 타이틀, 별점, 작가명 설정
        // TODO : 타이틀 임지 ㅣ변경
        return cell
    }
}

// Step 2. UICollectionViewDelegateFlowLayout를 상속시켜서 UICollectionViewLayout로 Cell의 사이즈 설정
    // * Cell간의 간격은 [storyboard] - Collection View - [size inspector]에서 설정할 수 있다
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width / 3
        let height =  width * 2
        
        return CGSize(width: width, height: height)
    }
}
