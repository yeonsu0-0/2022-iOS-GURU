//
//  ViewController.swift
//  UserEmailLogin
//
//  Created by yeonsu on 2023/01/13.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var userpwd: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didLogin(_ sender: Any) {
        
               let id: String = userid.text!.description
               let pwd: String = userpwd.text!.description
        
               // Firebase Auth Login
               Auth.auth().signIn(withEmail: id, password: pwd) {authResult, error in
                   if authResult != nil {
                       print("로그인 성공")
                       let newVC = self.storyboard?.instantiateViewController(identifier: "loginSuccess")
                       newVC?.modalTransitionStyle = .coverVertical
                       newVC?.modalPresentationStyle = .fullScreen
                              self.present(newVC!, animated: true, completion: nil)
                   } else {
                       print("로그인 실패")
                       print(error.debugDescription)
                   }
                   
               }
    }
    
}
