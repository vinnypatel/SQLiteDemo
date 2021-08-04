//
//  File.swift
//  AZAYM
//
//  Created by Vinay Patel on 27/02/19.
//  Copyright © 2019 GHPL. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundableButton : UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
//    @IBInspectable var startColor: UIColor = UIColor.white {
//        didSet{
//            setupView()
//        }
//    }
//
//    @IBInspectable var endColor: UIColor = UIColor.black {
//        didSet{
//            setupView()
//        }
//    }
//
//    @IBInspectable var isHorizontal: Bool = false {
//        didSet{
//            setupView()
//        }
//    }
//
//    @IBInspectable var roundness: CGFloat = 0.0 {
//        didSet{
//            setupView()
//        }
//    }
//
//    // MARK: Overrides ******************************************
//
//    class func layerClass()->AnyClass{
//        return CAGradientLayer.self
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//
//    // MARK: Internal functions *********************************
//
//    // Setup the view appearance
//    private func setupView(){
//
//        let colors:Array = [startColor.cgColor, endColor.cgColor]
//        gradientLayer.colors = colors
//        gradientLayer.cornerRadius = roundness
//
//        if (isHorizontal){
//            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        }else{
//            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//        }
//
//        self.setNeedsDisplay()
//
//    }
//
//    // Helper to return the main layer as CAGradientLayer
//    var gradientLayer: CAGradientLayer {
//        return layer as! CAGradientLayer
//    }
    
//    let gradientLayer = CAGradientLayer()
//
//    @IBInspectable
//    var topGradientColor: UIColor? {
//        didSet {
//            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
//        }
//    }
//
//    @IBInspectable
//    var bottomGradientColor: UIColor? {
//        didSet {
//            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
//        }
//    }
//
//    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
//        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
//            gradientLayer.frame = bounds
//            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) //(0.0, 0.5)
//            gradientLayer.endPoint = CGPoint(x:1.0, y: 0.5)
//            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
//            gradientLayer.borderColor = layer.borderColor
//            gradientLayer.borderWidth = layer.borderWidth
//            gradientLayer.cornerRadius = layer.cornerRadius
//            layer.insertSublayer(gradientLayer, at: 0)
//        } else {
//            gradientLayer.removeFromSuperlayer()
//        }
//    }
}

