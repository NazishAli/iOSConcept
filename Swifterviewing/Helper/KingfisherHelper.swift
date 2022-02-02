//
//  KingfisherHelper.swift
//  Swifterviewing
//
//  Created by Nazish Ali on 02/02/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Kingfisher





extension UIImageView {
     func setImageForUrl(url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeHolderImage"))
    }
}
