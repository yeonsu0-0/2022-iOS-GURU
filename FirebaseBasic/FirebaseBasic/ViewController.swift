//
//  ViewController.swift
//  FirebaseBasic
//
//  Created by yeonsu on 2023/01/10.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class ViewController: UIViewController, FUIAuthDelegate {

    var handle:AuthStateDidChangeListenerHandle!
    let authUI = FUIAuth.defaultAuthUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authUI!.delegate = self
    }
    
    /* 인증 상태 수신 대기 */
    // 로그인한 사용자에 대한 정보가 필요한 앱의 각 뷰에 대해 리스너를 FIRAuth 개체에 연결
    // 이 리스너는 사용자의 로그인 상태가 변경될 때마다 호출
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          
            // 로그인 유무 확인
            if let currentUser = auth.currentUser {
                // 로그인 상태
                NSLog("Logged In")
                // 로그인 시 환영 메세지 띄우기
                if let displayName = currentUser.displayName {
                    let alertController = UIAlertController(title: "Welcome!", message: "\(displayName)", preferredStyle: .alert)   // 알림창
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: false, completion: nil)
                }
            } else {
                // 로그아웃 상태
                NSLog("Logged Out")
                let providers: [FUIAuthProvider] = [
                  FUIEmailAuth()
                ]
                self.authUI!.providers = providers
                let authVC = self.authUI!.authViewController()
                authVC.modalPresentationStyle = .fullScreen
                // authVC.setNavigationBarHidden(true, animated: false)
                self.present(authVC, animated: false, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
        // 다른 화면으로 넘어갈 때 리스너 제거
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        NSLog("Sign In")
        NSLog("\(authDataResult)")
    }

    @IBAction func didSignOut(_ sender: UIButton) {
        do {
            try authUI?.signOut()
        } catch {
            NSLog("Logout Error")
        }
        // 또는 do { try } catch { }문과 동일한 표현
        // try! authUI?.signOut()
        // try? authUI?.signOut()
    }
    
}

// authVC의 상위 View
extension FUIAuthBaseViewController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // cancel 버튼 없애기
        self.navigationItem.leftBarButtonItem = nil
        // self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
