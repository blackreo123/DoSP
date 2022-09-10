//
//  UITextFieldEx.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/10.
//

import Foundation
import UIKit
import SnapKit

extension UITextField {
    func addBottomLine(borderWidth: CGFloat = 1.0, color: UIColor) {
        self.borderStyle = .none
        let borderView = UIView()
        borderView.backgroundColor = color
        self.addSubview(borderView)
        borderView.snp.makeConstraints({
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(self.snp.bottom).offset(borderWidth)
            $0.height.equalTo(borderWidth)
        })
    }
}
