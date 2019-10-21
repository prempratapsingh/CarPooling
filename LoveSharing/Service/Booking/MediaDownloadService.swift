//
//  MediaDownloadService.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

typealias ImageDownloadCompletionHandler = (UIImage?, String?) -> Void

class MediaDownloadService {
    
    func downloadImage(from url: String, completionHandler: @escaping ImageDownloadCompletionHandler) {
        let error = "Oops! Something went wrong, couldn't load vehicle image!"
        guard !url.isEmpty,
            let imageUrl = URL(string: url) else {
            completionHandler(nil, error)
            return
        }
        
        Alamofire.request(imageUrl).responseImage { response in
            guard let image = response.result.value else {
                completionHandler(nil, error)
                return
            }
            completionHandler(image, nil)
        }
    }
}
