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
import AuthenticationServices
import SnapKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginWithEmailButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginWithGoogleButton: GIDSignInButton!
    @IBOutlet weak var loginWithAppleButton: ASAuthorizationAppleIDButton!
    
    var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LogIn"
        setButtonLayout()
        setTextFieldLayout()
    }
    
    private func setTextFieldLayout() {
        [emailTextField, passwordTextField].forEach({
            self.setToolbar(textField: $0!)
            $0!.snp.makeConstraints({
                $0.height.equalTo(35)
            })
        })
        emailTextField.addBottomLine(borderWidth: 2, color: .black)
        passwordTextField.addBottomLine(borderWidth: 2, color: .black)
    }
    
    private func setButtonLayout() {
        [loginWithEmailButton, createAccountButton, loginWithGoogleButton].forEach { button in
            button?.layer.cornerRadius = 10
            button?.layer.borderWidth = 1
            button?.tintColor = .darkGray
            button?.snp.makeConstraints({
                $0.height.equalTo(58)
            })
        }

        loginWithAppleButton.snp.makeConstraints({
            $0.height.equalTo(58)
        })
    }
    
    @IBAction func emailLoginButtonTapped(_ sender: UIButton) {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        self.loginUserWithEmailAndPassword(withEmail: email, password: password)
    }
    
    func goMainViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "TestViewController")
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    private func loginUserWithEmailAndPassword(withEmail email: String, password: String) {
        Loading.showLoading()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else {
                Loading.hideLoading()
                return
            }
            if let error = error {
                Loading.hideLoading()
                Alerts.showAlertAction(message: error.localizedDescription, completeTitle: "OK")
            } else {
                guard let isEmailVerified = Auth.auth().currentUser?.isEmailVerified else {
                    Loading.hideLoading()
                    Alerts.showAlertAction(message: "your email is not Verified please check your email")
                    return
                }
                
                if isEmailVerified {
                    Loading.hideLoading()
                    self.goMainViewController()
                } else {
                    Loading.hideLoading()
                    Alerts.showAlertAction(message: "your email is not Verified please check your email")
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
        Loading.showLoading()
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            Loading.hideLoading()
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                Loading.hideLoading()
                Alerts.showAlertAction(message: error.localizedDescription, completeTitle: "OK")
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                Loading.hideLoading()
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authDataResult, error in
                if let error = error {
                    Loading.hideLoading()
                    Alerts.showAlertAction(message: error.localizedDescription, completeTitle: "OK")
                    return
                } else {
                    Loading.hideLoading()
                    self.goMainViewController()
                }
            }
        }
    }
    
    @IBAction func loginWithAppleButtonTapped(_ sender: UIButton) {
        self.performLoginWithApple()
    }
    
    private func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    private func performLoginWithApple() {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}
