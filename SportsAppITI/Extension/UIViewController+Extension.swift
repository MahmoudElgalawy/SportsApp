//
//  UIViewController+Extension.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
extension UIViewController {
    func presentViewController(withIdentifier identifier: String, storyboardName: String? = nil, modalPresentationStyle: UIModalPresentationStyle = .fullScreen, animated: Bool = true) {
        let storyboard = storyboardName != nil ? UIStoryboard(name: storyboardName!, bundle: nil) : self.storyboard
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            print("Error: View controller with identifier \(identifier) not found")
            return
        }
        vc.modalPresentationStyle = modalPresentationStyle
        self.present(vc, animated: animated, completion: nil)
    }
//    func PushViewController(withIdentifier identifier: String, storyboardName: String? = nil, animated: Bool = true,title:String = "") {
//        let storyboard = storyboardName != nil ? UIStoryboard(name: storyboardName!, bundle: nil) : self.storyboard
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) else {
//            print("Error: View controller with identifier \(identifier) not found")
//            return
//        }
//        vc.navigationItem.title = title
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    func creatViewController(withIdentifier identifier: String, storyboardName: String?)->UIViewController {
        let storyboard = storyboardName != nil ? UIStoryboard(name: storyboardName!, bundle: nil) : self.storyboard
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            print("Error: View controller with identifier \(identifier) not found")
            return UIViewController()
        }
        return vc
    }

}

