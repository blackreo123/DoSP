//
//  Alerts.swift
//  DoSP
//
//  Created by JIHA YOON on 2022/09/01.
//

import Foundation
import UIKit

class Alerts {
    static func showAlertAction(viewController: UIViewController, preferredStyle: UIAlertController.Style = .alert, title: String = "", message: String = "", completeTitle: String = "Yes", completeHandler:(() -> Void)? = nil){
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
                    
                    let completeAction = UIAlertAction(title: completeTitle, style: .default) { action in
                        completeHandler?()
                    }
                    
                    alert.addAction(completeAction)
                    
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
    
    static func showAlertAction(viewController: UIViewController, preferredStyle: UIAlertController.Style = .alert, title: String = "", message: String = "", completeTitle: String = "Yes", cancelTitle: String = "Cancel", completeHandler:(() -> Void)? = nil, cancelHandler:(() -> Void)? = nil){
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
                    
                    let completeAction = UIAlertAction(title: completeTitle, style: .default) { action in
                        completeHandler?()
                    }
                    
                    let cancelAction = UIAlertAction(title: completeTitle, style: .cancel) { action in
                        cancelHandler?()
                    }
                    
                    alert.addAction(completeAction)
                    alert.addAction(cancelAction)
                    
                    viewController.present(alert, animated: true, completion: nil)
                }
            }
    
}
