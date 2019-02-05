//
//  RoundView.swift
//  CustomTabBar
//
//  Created by José Miguel Herrero on 03/01/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {
    
    //MARK: - Properties
    var color: UIColor = .blue
    var borderWidth: CGFloat = 2
    
    //MARK: - Lifecycle methods
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        color.setFill()
        path.fill()
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    
    }
}
