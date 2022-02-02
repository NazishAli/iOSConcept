//
//  Album.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Album {
    var id: Int
    var title: String = ""
    var imageUrl: String = ""
    
    var url: URL? {
        if let url = URL(string: imageUrl) {
             return url
        }
        
        return nil
    }

    init?(photo: [String: Any], album: [String: Any]) {
        guard let id = album["id"] as? Int else {
            return nil
        }

        self.id = id

        if let title = album["title"] as? String  {
            self.title = title
        }
        
        if let thumbnailUrl = photo["thumbnailUrl"] as? String  {
            self.imageUrl = thumbnailUrl
        }
    }
}
