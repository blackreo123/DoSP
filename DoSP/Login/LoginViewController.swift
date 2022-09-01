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
        self.loginUser(withEmail: email, password: password)
        
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
                    Alerts.showAlertAction(viewController: self, message: error.localizedDescription, completeTitle: "OK")
                } else {
                    self.goMainViewController()
                }
            }
        }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let createUserViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserViewController")
        self.navigationController?.pushViewController(createUserViewController, animated: true)
    }
}
