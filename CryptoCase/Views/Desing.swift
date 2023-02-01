//
//  Desing.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 30.01.2023.
//

import Foundation
import UIKit

@IBDesignable
class Design: UIView {
    
    //MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            
            self.layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            
            self.layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor! {
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }
}
