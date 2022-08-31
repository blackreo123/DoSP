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
    
    // TODO: - print -> alert
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let email = self.createEmailTextField.text,
              let password = self.createPasswordTextField.text,
              let passwordConfirm = self.createPasswordConfirmTextField.text else {
            print("input all")
            return
        }
        
        if password == passwordConfirm {
            
            Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
                guard let self = self else { return }
                print("authResult: \(authResult.debugDescription)")
                if let error = error {
                    let code = (error as NSError).code
                    
                    switch code {
                    case 17007:
                        // email address is already in use by another account
                        print("already have that email")
                        return
                    default:
                        print("error")
                        return
                    }
                } else {
                    print("create success")
                    return
                }
            }
        } else {
            print("password not equal with password Confirm")
            return
        }
    }
}