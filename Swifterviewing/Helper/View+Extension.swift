//
//  View+Extension.swift
//  Swifterviewing
//
//  Created by Nazish Ali on 02/02/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit


// MARK: - TableView
extension  UITableView {
  
 func registerCell(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
    var identifier = identifier
    if identifier.isEmpty {
      identifier = nibName
    }
    let nib: UINib = UINib(nibName: nibName, bundle: bundle)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  func registerHeaderFooter(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
    var identifier = identifier
    if identifier.isEmpty {
      identifier = nibName
    }
    let nib: UINib = UINib(nibName: nibName, bundle: bundle)
    self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
  }
}

extension  UIView {
   
    func setCornerRadius() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
