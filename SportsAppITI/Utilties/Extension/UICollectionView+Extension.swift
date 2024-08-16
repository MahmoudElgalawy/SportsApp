//
//  UICollectionView+Extension.swift
//  SportsAppITI
//
//  Created by Engy on 8/16/24.
//

import UIKit
extension UICollectionView {
//    func animateCellsSlide() {
//            let offset: CGFloat = 50.0
//            let originalPosition = self.frame.origin
//            self.frame.origin.x += offset
//
//            UIView.animate(withDuration: 0.3) {
//                self.frame.origin = originalPosition
//            }
//        }
    func animateCellsSlideInFromBottom() {
            let originalPosition = self.frame.origin

            // Start off-screen
            self.frame.origin.y += self.bounds.height

            UIView.animate(withDuration: 0.5) {
                self.frame.origin = originalPosition
            }
        }


}
