//
//  UIApplicationEx.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/04.
//

import Foundation
import UIKit

extension UIApplication {
    // MARK: - get key window
    static var firstKeyWindowForConnectedScenes: UIWindow? {
        UIApplication.shared
        // Of all connected scenes...
            .connectedScenes.lazy
        
        // ... grab all foreground active window scenes ...
            .compactMap { $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }
        
        // ... finding the first one which has a key window ...
            .first(where: { $0.keyWindow != nil })?
        
        // ... and return that window.
            .keyWindow
    }
}
