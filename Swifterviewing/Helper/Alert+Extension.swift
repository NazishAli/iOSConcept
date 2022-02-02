//
//  Alert+Extension.swift
//  Swifterviewing
//
//  Created by Nazish Ali on 02/02/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
  
  func present(viewController: UIViewController) {
      viewController.present(self, animated: true, completion: nil)
  }
  
  func present() {
    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
      self.present(viewController: viewController)
    }
  }
  
  @discardableResult
    func action(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
    let action: UIAlertAction = UIAlertAction(title: title, style: style, handler: handler)
    self.addAction(action)
    return self
  }
  
  @discardableResult
    class func alert(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
    let alertController: UIAlertController  = UIAlertController(title: title, message: message, preferredStyle: style)
    return alertController
  }
  
  @discardableResult
    class func presentAlert(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
    let alertController = UIAlertController.alert(title: title, message: message, style: style)
    alertController.present()
    return alertController
  }
  
}

