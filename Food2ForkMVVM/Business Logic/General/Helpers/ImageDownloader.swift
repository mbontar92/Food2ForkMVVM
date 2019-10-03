//
//  ImageDownloader.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/3/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

class ImageDownloader {

    static func download(url: String?, completion: @escaping ((_ image: UIImage?)->Void)) {
        guard let imageUrl = URL(string: url ?? "") else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: imageUrl)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                print(requestError.localizedDescription)
                completion(nil)
                return
            }
            
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            completion(UIImage(data: responseData))
        }
        session.resume()
    }
}
