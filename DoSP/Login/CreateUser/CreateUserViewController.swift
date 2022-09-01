//
//  CreateUserViewController.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/01.
//

import Foundation
import UIKit
import FirebaseAuth

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var creatEmailStackView: UIStackView!
    @IBOutlet weak var createEmailTextField: UITextField!
    @IBOutlet weak var createPasswordTextField: UITextField!
    @IBOutlet weak var createPasswordConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configure() {
        
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let email = self.createEmailTextField.text,
              let password = self.createPasswordTextField.text,
              let passwordConfirm = self.createPasswordConfirmTextField.text else { return }
        
        if password == passwordConfirm {
            
            Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
                guard let self = self else { return }
                
                if let error = error {
                    Alerts.showAlertAction(viewController: self, message: error.localizedDescription, completeTitle: "OK")
                    return
                } else {
                    Auth.auth().currentUser?.sendEmailVerification { error in
                        if let error = error {
                            Alerts.showAlertAction(viewController: self, message: error.localizedDescription, completeTitle: "OK")
                        } else {
                            Alerts.showAlertAction(viewController: self, message: "we send verify email please check you email", completeTitle: "OK") {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                    return
                }
            }
        } else {
            Alerts.showAlertAction(viewController: self, message: "password not equal with password Confirm")
            return
        }
    }
}
