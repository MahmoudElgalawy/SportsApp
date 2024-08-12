//
//  UILabel+Extension.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
extension UILabel{
    func fadeInLabel(label: UILabel) {
        label.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            label.alpha = 1.0
        }
    }
    func fadeOutLabel(label: UILabel) {
        UIView.animate(withDuration: 0.5) {
            label.alpha = 0.7
        }
        UIView.animate(withDuration: 0.5) {
            label.alpha = 1
        }

    }
    func moveLabel(label: UILabel) {
        let originalPosition = label.center
        UIView.animate(withDuration: 0.7, animations: {
            label.center = CGPoint(x: originalPosition.x + 100, y: originalPosition.y)})
        UIView.animate(withDuration: 0.5, animations:{
                label.center = originalPosition})
        }
    }
func scaleLabel(label: UILabel,withDuration: Double) {
        UIView.animate(withDuration: withDuration, animations: {
            label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)})
        UIView.animate(withDuration: 0.3, animations: {
                label.transform = CGAffineTransform.identity})
    }
    func rotateLabel(label: UILabel) {
        UIView.animate(withDuration: 0.5, animations: {
            label.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                label.transform = CGAffineTransform.identity
            }
        }
    }



