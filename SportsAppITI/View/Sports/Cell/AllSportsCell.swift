//
//  SportsCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class AllSportsCell: UICollectionViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var img: UIImageView!
    @IBOutlet var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updatUi()
    }
    func updatUi(){
        img.addRadiusView(10)
        lbl.moveLabel(label: lbl)
        animateImageView(imageView: img)
        img.addBorderView(color: Color.CC328B9, width: 1)
    }

    func configure(with model: SportsItemModel){
        img.image = UIImage(named:model.imgName)
        lbl.text = model.titleName
    }

}


