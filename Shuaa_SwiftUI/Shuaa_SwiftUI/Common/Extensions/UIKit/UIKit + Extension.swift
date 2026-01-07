//
//  UIKit + Extension.swift
//  Shuaa
//
//  Created by FIT on 15/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    class func fromNib<T: UIView>() -> T {

        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    func addConstraint(leading:CGFloat? = nil,top:CGFloat,bottom:CGFloat? = nil,trailing:CGFloat? = nil,height:CGFloat? = nil) {
        let view = self
        guard let parentView = self.superview else{return}

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: top).isActive = true
        if let leading = leading{
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing{
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: trailing).isActive = true
        }
        if let bottom = bottom{
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: bottom).isActive = true
        }

        if let height = height{
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
}


extension UIViewController{

    func checkViewControllerExist(scene: any BaseSceneType.Type)->Bool {
        guard let presentedView = self.presentedViewController?.view else{return true}
        return "\(presentedView )".contains("\(scene.self)")
    }
}
