//
//  ViewController.swift
//  area-calculator
//
//  Created by yeonsu on 2022/12/30.
//

import UIKit

class ViewController: UIViewController {
    
    // 빈 공간 화면을 눌렀을 때 키보드 없애기
    @IBAction func dismissKeyboard(_ sender: Any) {
        widthTextfield.resignFirstResponder()
        lengthTextfield.resignFirstResponder()
    }
    
    // 보여지는 자릿수 설정
    let numberFormatter:NumberFormatter = {
       let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()

    @IBOutlet weak var widthTextfield: UITextField!
    @IBOutlet weak var lengthTextfield: UITextField!
    @IBOutlet weak var areaTextfield: UITextField!
    
    @IBAction func calBtn(_ sender: Any) {
        // 옵셔널 언래핑
        if let value1 = widthTextfield.text, let number1 = Double(value1), let value2 = lengthTextfield.text, let number2 = Double(value2) { let area = number1*number2
            
            areaTextfield.text = numberFormatter.string(from: NSNumber(value: area))
            
            widthTextfield.resignFirstResponder()
        }
        

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

