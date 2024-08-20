//
//  UIView+Extension.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
extension UIView {
   

    func animateImageView(imageView: UIImageView) {
        UIView.animate(withDuration: 0.6,animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)})
        UIView.animate(withDuration: 0.6, animations:{
            imageView.transform = CGAffineTransform.identity
        })
    }
    func animateImageView() {
        UIView.animate(withDuration: 0.6) {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.6) {
            self.transform = CGAffineTransform.identity
        }
    }
    func animateCellsSlide() {
            let offset: CGFloat = 90.0
            let originalPosition = self.frame.origin
            self.frame.origin.x += offset

            UIView.animate(withDuration: 0.3) {
                self.frame.origin = originalPosition
            }
        }
    func animateSlideAndFadeIn(duration: TimeInterval = 0.6, delay: TimeInterval = 0.1, options: UIView.AnimationOptions = [.curveEaseIn], completion: ((Bool) -> Void)? = nil) {
            // Apply initial state
            self.transform = CGAffineTransform(translationX: 0, y: 30)
            self.alpha = 0

            // Perform animation
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                self.transform = .identity
                self.alpha = 1
            }, completion: completion)
        }
    func animateCellAppearance(translationX: CGFloat = 0, translationY: CGFloat = 30, duration: TimeInterval = 0.6, delay: TimeInterval = 0.1, options: UIView.AnimationOptions = [.curveEaseIn], completion: ((Bool) -> Void)? = nil) {
            self.transform = CGAffineTransform(translationX: translationX, y: translationY)
            self.alpha = 0
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                self.transform = .identity
                self.alpha = 1
            }, completion: completion)
        }
}


