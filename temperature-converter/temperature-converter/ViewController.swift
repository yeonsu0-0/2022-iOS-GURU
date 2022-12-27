//
//  ViewController.swift
//  temperature-converter
//
//  Created by yeonsu on 2022/12/27.
//

import UIKit

class ViewController: UIViewController {

    
    //IBOutlet: UI 요소를 변수에 연결
    //IBAction: UI 요소의 이벤트를 연결
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!

    // 빈 공간 화면을 눌렀을 때 키보드 없애기
    @IBAction func dismissKeyboard(_ sender: Any) {
        text1.resignFirstResponder()
        text2.resignFirstResponder()
    }
    
    
    
    @IBAction func convertBtn(_ sender: UIButton) {
        
        // print(text1.text, text2.text)
        // var text: String? { get set } -> 옵셔널 타입
        // 입력값이 Optional("123")와 같이 출력됨
        
        // 옵셔널 언래핑
        if let value1 = text1.text, let number1 = Double(value1) {   // 값이 있다면
            // print(value1, number1)     // 출력
            // value1의 값이 문자라면? Double로 형변환이 안 되기 때문에 둘 다 출력X
            //
            // 섭씨 -> 화씨 변환: 섭씨 * 1.8 + 32
            let fahrenheit = number1 * 1.8 + 32
            // text2.text = "\(fahrenheit)"    // 숫자를 변수에 할당하는 방법: "\()"
            text2.text = numberFormatter.string(from: NSNumber(value: fahrenheit))
            text1.resignFirstResponder()    // 키보드가 필요없는 상태임을 인지
        }
        print("버튼이 눌렸습니다.")
    }
    
    
    // 보여지는 자릿수 설정
    let numberFormatter:NumberFormatter = {
       let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("앱 화면이 나타납니다.")
    }


}


