//
//  UIView+Extension.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
extension UIView {
    func addRadiusView(_  radius: CGFloat){
        self.layer.cornerRadius = radius
    }
    func addBorderView(color:Color,width:CGFloat){
        self.layer.borderColor = UIColor(named:color.rawValue)?.cgColor
        self.layer.borderWidth = width
    }

    func animateImageView(imageView: UIImageView) {
        UIView.animate(withDuration: 0.8,animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)})
        UIView.animate(withDuration: 0.4, animations:{
            imageView.transform = CGAffineTransform.identity
        })
    }
}


