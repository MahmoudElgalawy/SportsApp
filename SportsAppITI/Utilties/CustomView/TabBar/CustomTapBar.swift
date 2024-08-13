//
//  CustomTapBar.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit


import UIKit

class CustomTapBar: UITabBar {

    @IBOutlet var mainView: UIView!

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var customView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()
        //customView.addRadiusView(30)
        imgView.animateImageView(imageView: imgView)
        imgView.addRadiusView(20)
       // imgView.alpha = 0.3
        imgView.addBorderView(color: Color.C8E8E93, width: 2)
    }

    private func loadNib() {
        Bundle.main.loadNibNamed("CustomTapBar", owner: self, options: nil)
        if let mainView = mainView {
            addSubview(mainView)
            mainView.frame = self.bounds
            mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sendSubviewToBack(mainView)
        }
    }
}
