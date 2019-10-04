//
//  LoadingAnimation.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/2/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit


class LoadingAnimation {
    
    func loadningProgressCircleAnimationStart( view: UIView, layer: CAShapeLayer) {
        
        createLayer(inputLayer: layer, shapeLayerCircularPath: UIBezierPath(arcCenter: view.center,radius: 50.0,startAngle: -CGFloat.pi / 2,endAngle: CGFloat.pi + CGFloat.pi / 2, clockwise: true), lineWidth: 11)
        
        view.layer.addSublayer(layer)
    }
    // MARK: Create Layer Function
    func createLayer(inputLayer: CAShapeLayer, shapeLayerCircularPath: UIBezierPath, lineWidth: CGFloat) ->  CAShapeLayer {
        
        inputLayer.path = shapeLayerCircularPath.cgPath
        inputLayer.strokeColor =   UIColor.init(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).cgColor
        inputLayer.lineWidth = lineWidth
        inputLayer.lineCap = CAShapeLayerLineCap.round
        inputLayer.fillColor = UIColor.clear.cgColor
        inputLayer.strokeEnd = 0.0001
        
        return inputLayer
    }
    
    func LoadingProgressCircleAnimationFinish () {
        
        
    }
}



