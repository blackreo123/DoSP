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
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginWithGoogleButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emailLoginButtonTapped(_ sender: UIButton) {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        self.loginUserWithEmailAndPassword(withEmail: email, password: password)
        
    }
    
    private func goMainViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "TestViewController")
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    private func loginUserWithEmailAndPassword(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else {return}
            if let error = error {
                Alerts.showAlertAction(viewController: self, message: error.localizedDescription, completeTitle: "OK")
            } else {
                guard let isEmailVerified = Auth.auth().currentUser?.isEmailVerified else {
                    Alerts.showAlertAction(viewController: self, message: "your email is not Verified please check your email")
                    return
                }
                
                if isEmailVerified {
                    self.goMainViewController()
                } else {
                    Alerts.showAlertAction(viewController: self, message: "your email is not Verified please check your email")
                }
            }
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let createUserViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserViewController")
        self.navigationController?.pushViewController(createUserViewController, animated: true)
    }
    
    @IBAction func loginWithGoogleButtonTapped(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                Alerts.showAlertAction(viewController: self, message: error.localizedDescription, completeTitle: "OK")
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authDataResult, error in
                if let error = error {
                    Alerts.showAlertAction(viewController: self, message: error.localizedDescription, completeTitle: "OK")
                    return
                } else {
                    self.goMainViewController()
                }
            }
        }
    }
    
}
