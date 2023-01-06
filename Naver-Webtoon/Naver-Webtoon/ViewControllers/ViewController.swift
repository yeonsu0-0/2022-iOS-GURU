//
//  ViewController.swift
//  Naver-Webtoon
//
//  Created by yeonsu on 2023/01/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webtoonCollectionView: UICollectionView!

    // Step 5. 구조체로 데이터 생성 (WebtoonData.swift)
    var webtoonData = [
    WebToonData("팔이피플", "title01", 4.8, "매미/희세"),
    WebToonData("루루라라 우리네 인생", "title02", 4.8, "현이씨"),
    WebToonData("순정말고 순종", "title03", 4.7, "슈안"),
    WebToonData("웅크", "title04", 4.9, "나유진"),
    WebToonData("소공녀 민트", "title05", 4.6, "봉이/갈피/오윤"),
    WebToonData("안녕, 나의 수집", "title06", 4.8, "하린"),
    WebToonData("여신강림", "title07", 4.8, "야옹이"),
    WebToonData("독립일기", "title08", 4.9, "자까"),
    WebToonData("마루는 강쥐", "title09", 4.8, "모죠"),
    WebToonData("약한영웅", "title10", 4.8, "서패스/김진석")
    ]
    
    var webtoonTitle = [
    "팔이피플"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    /* error
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(self.webtoonCollectionView.indexPathsForSelectedItems)
        if let indexPath = self.webtoonCollectionView.indexPathsForSelectedItems?.first {
            let webtoon_info = webtoonData[indexPath.row]
            if let vc = segue.destination as? SubViewController {
                vc.titles.text = webtoon_info.title
            }
        }
    }
    */

}


// Step 1. UICollectionViewDataSource를 상속시켜서 numberOfItemsInSection, cellForItemAt 구현
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webtoonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Step 3. Custom Cell을 만들기 위한 파일 생성 (WebtoonCell.swift)
        
        // Step 4. WebToonCell로 타입 캐스팅 문법 추가(as! WebToonCell)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webToonCell", for: indexPath) as! WebToonCell

        // Step 3-1. 데이터 설정 -> Step 6. 데이터 가져오기
        // TODO : 타이틀, 별점, 작가명 설정
        let data = webtoonData[indexPath.row]
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "\(data.rating!)"
        cell.authorLabel.text = data.author
        // TODO : 타이틀 이미지 변경
        cell.titleImage.image = UIImage(named: data.title_image)
        
        // 웹툰 간 간격에 stroke 추가
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        
        return cell
    }
}

// Step 2. UICollectionViewDelegateFlowLayout를 상속시켜서 UICollectionViewLayout로 Cell의 사이즈 설정
    // * Cell간의 간격은 [storyboard] - Collection View - [size inspector]에서 설정할 수 있다
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // let width = self.view.frame.size.width / 3
        let width = UIScreen.main.bounds.width / 3
        let height =  width * 1.9
        
        return CGSize(width: width, height: height)
    }
}
