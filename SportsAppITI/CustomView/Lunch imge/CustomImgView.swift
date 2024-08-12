//
//  CustomImgView.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import UIKit
import Kingfisher

class CustomImgView: UIView {
    @IBOutlet var myImg: UIImageView!
    @IBOutlet var main: UIView!
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
        guard let gifURL = Bundle.main.url(forResource: "1", withExtension: "gif") else { return }
        let resource = KF.ImageResource(downloadURL: gifURL)
        myImg.kf.setImage(with: resource)
           }

    private func loadNib() {
        Bundle.main.loadNibNamed("CustomImgView", owner: self, options: nil)
        if let mainView = main {
            addSubview(mainView)
            mainView.frame = self.bounds
            mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sendSubviewToBack(mainView)
        }
    }

   

}
