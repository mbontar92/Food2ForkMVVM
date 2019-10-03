//
//  ImageFromUrl.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/3/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(imageStringUrl: String?){
        
        if let imageUrl = imageStringUrl {
            if let url = URL(string: imageUrl) {
                let request = URLRequest(url: url)
                let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    if let requestError = error {
                        print(requestError.localizedDescription)
                        return
                    }
                    guard let responseData = data else { return }
                    DispatchQueue.main.async {
                        // setting in main queue
                        self.image = UIImage(data: responseData)
                    }
                }
                session.resume()
            }
        }
    }
}
