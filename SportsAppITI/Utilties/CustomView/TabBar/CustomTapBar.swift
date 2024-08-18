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
        imgView.animateImageView(imageView: imgView)
        imgView.addRadiusView(20)
        imgView.addBorderView(color: Color.C8E8E93, width: 1.5)
    }

    private func loadNib() {
            guard let nib = Bundle.main.loadNibNamed("CustomTapBar", owner: self, options: nil),
                  let mainView = nib.first as? UIView else {return}
            self.mainView = mainView
            addSubview(mainView)
            mainView.frame = self.bounds
            mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sendSubviewToBack(mainView)
        }
}
