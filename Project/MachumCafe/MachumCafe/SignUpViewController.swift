//
//  SignUpViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cofirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        navigationController?.isNavigationBarHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        if passwordTextField.text! != cofirmPasswordTextField.text! {
            let alert = UIAlertController(title: "Alert", message: "비밀번호가 일치하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        NetworkUser.register(email: emailTextField.text!, password: passwordTextField.text!, nickname: nicknameTextField.text!) { (message) in
            if message {
                UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "회원가입 완료 :)", isHandler: true)
            } else {
                UIAlertController().oneButtonAlert(target: self, title: "회원가입", message: "이미 가입된 사용자입니다.", isHandler: false)
            }
        }
    }
}


