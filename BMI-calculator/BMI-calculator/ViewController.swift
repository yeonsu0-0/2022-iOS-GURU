//
//  ViewController.swift
//  BMI-calculator
//
//  Created by yeonsu on 2022/12/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var bmiField: UITextField!
    
    
    // 보여지는 자릿수 설정
    let numberFormatter:NumberFormatter = {
       let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    //
    
    
    // 화면 빈 공간 누르면 키보드 내리기
    @IBAction func dismissKeyboard(_ sender: Any) {
        // weightField.resignFirstResponder()
        // heightField.resignFirstResponder()
        view.endEditing(true)
    }
    
    
    @IBAction func bmiCalculation(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText), let weightText = weightField.text, let weight = Double(weightText) {
            let bmi = weight / ((height/100)*(height/100))
            bmiField.text = numberFormatter.string(from: NSNumber(value: bmi))
        }
        view.endEditing(true)
    }
    
    // text 입력 후 return 키 누르면 이동
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}



