//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by Nazish Ali on 02/02/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation



class AlbumViewModel {
   
    
    let downloadGroup = DispatchGroup()
    var albumList: [Album] = []
    var callBack: ((_ isSucess: Bool, _ message: String?) -> Void)?
    
    init() {
       
    }
    
    
    
    func getAlbums() {
        var photoResult: [[String: Any]]?
        var albumsResult: [[String: Any]]?
        var error: String?
        downloadGroup.enter()
        HTTPRequest().sendRequestToServer(param: [:], requestType: .get, urlString: SubstringUrl.photosEndpoint) { [weak self] (result) in
            print("Photo Results")
            
            if result.value != nil {
               // print(result.value)
                photoResult = result.value as? [[String: Any]]
            } else {
                error = result.error?.localizedDescription
            }
            self?.downloadGroup.leave()
        }
       
       // self.downloadGroup.wait()
        downloadGroup.enter()
        HTTPRequest().sendRequestToServer(param: [:], requestType: .get, urlString: SubstringUrl.albumsEndpoint) { [weak self] (result) in
            print("Album Results")
            if result.value != nil {
              //  print(result.value)
                albumsResult = result.value as? [[String: Any]]
            } else {
                    error = result.error?.localizedDescription
            }
            self?.downloadGroup.leave()
           
        }
        
        
        downloadGroup.notify(queue: .main) { [weak self] in
            print("Sucessful Api Completed")
            if error != nil {
                self?.callBack!(false, error)
            } else {
               self?.createAlbumsModel(photos: photoResult, albums: albumsResult)
            }
        }
       
    }
    
    func createAlbumsModel(photos: [[String: Any]]?, albums: [[String: Any]]?) {
        
        if let photoList = photos, let albumList = albums {
            
            for album in albumList {
                for photo in photoList {
                    
                    if let id = album["id"] as? Int, let aId = photo["albumId"] as? Int {
                        if id == aId {
                            if var albumModel = Album(photo: photo, album: album) {
                               let title = albumModel.title.replacingOccurrences(of: "e", with: "")
                                albumModel.title = title
                               self.albumList.append(albumModel)
                            }
                            break
                        }
                        
                    }
               }
            }
            
            callBack!(true, nil)
        } else {
            callBack!(false, nil)
        }
        
        
       
//        for album in self.albumList {
//            print(album.id)
//            print(album.title)
//        }
    }

}
