//
//  CreateUserViewController.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/01.
//

import Foundation
import UIKit
import FirebaseAuth
import SnapKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var creatEmailStackView: UIStackView!
    @IBOutlet weak var createEmailTextField: UITextField!
    @IBOutlet weak var createPasswordTextField: UITextField!
    @IBOutlet weak var createPasswordConfirmTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.title = "Sign In"
        self.setTextFieldLayout()
        self.setButtonLayout()
    }
    
    private func setTextFieldLayout() {
        [createEmailTextField, createPasswordTextField, createPasswordConfirmTextField].forEach({
            self.setToolbar(textField: $0!)
            $0!.snp.makeConstraints({
                $0.height.equalTo(35)
            })
        })
        createEmailTextField.addBottomLine(borderWidth: 2, color: .black)
        createPasswordTextField.addBottomLine(borderWidth: 2, color: .black)
        createPasswordConfirmTextField.addBottomLine(borderWidth: 2, color: .black)
    }
    
    private func setButtonLayout() {
        self.signInButton.layer.cornerRadius = 10
        self.signInButton.layer.borderWidth = 1
        self.signInButton.tintColor = .darkGray
        self.signInButton.titleLabel?.text = "Sign In"
        self.signInButton.snp.makeConstraints({
            $0.height.equalTo(60)
        })
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        Loading.showLoading()
        guard let email = self.createEmailTextField.text,
              let password = self.createPasswordTextField.text,
              let passwordConfirm = self.createPasswordConfirmTextField.text else {
            Loading.hideLoading()
            return
        }
        
        if password == passwordConfirm {
            
            Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
                guard let self = self else {
                    Loading.hideLoading()
                    return
                }
                
                if let error = error {
                    Loading.hideLoading()
                    Alerts.showAlertAction(message: error.localizedDescription, completeTitle: "OK")
                    return
                } else {
                    Auth.auth().currentUser?.sendEmailVerification { error in
                        if let error = error {
                            Loading.hideLoading()
                            Alerts.showAlertAction(message: error.localizedDescription, completeTitle: "OK")
                        } else {
                            Alerts.showAlertAction(message: "we send verify email please check you email", completeTitle: "OK") {
                                FirebaseStore.shared.addData(data: ["email": "blackreo123@naver.com"])
                                Loading.hideLoading()
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                    return
                }
            }
        } else {
            Loading.hideLoading()
            Alerts.showAlertAction(message: "password not equal with password Confirm")
            return
        }
    }
}
