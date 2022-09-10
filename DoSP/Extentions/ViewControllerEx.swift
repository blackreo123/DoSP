//
//  ViewControllerEx.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/10.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setToolbar(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([space ,doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(){
        view.endEditing(true)
    }
}
