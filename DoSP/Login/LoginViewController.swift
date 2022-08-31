//
//  LoginViewController.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/08/31.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emailLoginButtonTapped(_ sender: UIButton) {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        // need to move create user page
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                
                switch code {
                case 17007:
                    // email address is already in use by another account
                    self.loginUser(withEmail: email, password: password)
                default:
                    print("error")
                }
            } else {
                self.goMainViewController()
            }
            
        }
    }
    
    private func goMainViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "TestViewController")
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    private func loginUser(withEmail email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
                guard let self = self else {return}
                if let error = error {
                    print("error")
                } else {
                    self.goMainViewController()
                }
            }
        }
}
