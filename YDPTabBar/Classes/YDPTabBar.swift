//
//  YDPTabBar.swift
//  CustomTabBar
//
//  Created by José Miguel Herrero on 03/01/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import UIKit

@IBDesignable
open class YDPTabBar: UITabBar {
    
    //MARK: - Statics properties
    static var inset: CGFloat = 24
    
    //MARK: IBInspectable
    @IBInspectable var selectColor: UIColor = .blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: - Lifecycle methods
    override open func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 0, height: 0))
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.layer.shadowOpacity = 0.22
        self.layer.shadowRadius = 5
        
        //To draw the circle in de interface builder
        if let item = self.selectedItem {
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectColor], for: .selected)
            drawCircle(item: item)
        }
        //--
        
        UIColor.white.setFill()
        path.fill()
    }
    
    override open var selectedItem: UITabBarItem? {
        get {
            return super.selectedItem
        }
        set {
            let item = newValue
            item?.imageInsets.top = -YDPTabBar.inset
            item?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectColor], for: .selected)
            
            defaultPosition(item: item)
            drawCircle(item: item)
            super.selectedItem = item
        }
    }
    
    //MARK: - Private func
    private func defaultPosition(item: UITabBarItem?) {
        guard let items = self.items,
              let selected = item else {
            return
        }
        
        for item in items {
            if item != selected {
                item.imageInsets.top = 0
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            }
        }
    }
    
    private func drawCircle(item: UITabBarItem?) {
        guard let selected = item else {
                return
        }
        if let item = selected.value(forKey: "view") as? UIView {
            let height = item.frame.height
            let x = (item.frame.width / 2) - (height / 2)
            let y = (height / 2) - (YDPTabBar.inset / 3)
            let frame = CGRect(x: x, y: -y, width: height, height: height)
            
            let view = RoundView()
            view.frame = frame
            view.color = selectColor
            view.borderWidth = borderWidth
            view.backgroundColor = .clear
            
            item.addSubview(view)
        }
    }
}
