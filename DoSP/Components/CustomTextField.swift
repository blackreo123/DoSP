//
//  CustomTextField.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/10.
//

import Foundation
import UIKit

public class CustomTextField: UITextField {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField(textField: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTextField(textField: self)
    }
    
    func setTextField(textField: UITextField) {
        
    }
    
}
