//
//  ShadowToCell.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/2/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//


import UIKit

extension UIView {
    
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height ))
        self.addSubview(blurLoader)
    }
    
    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}
