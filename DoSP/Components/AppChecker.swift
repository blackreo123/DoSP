//
//  AppChecker.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/05.
//

import Foundation
import Firebase
import FirebaseAppCheck

class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        if #available(iOS 14.0, *) {
            return AppAttestProvider(app: app)
        } else {
            return DeviceCheckProvider(app: app)
        }
    }
}
