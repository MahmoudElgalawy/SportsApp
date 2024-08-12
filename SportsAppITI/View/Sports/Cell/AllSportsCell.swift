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
        animateImageView(imageView: img)
        img.addRadiusView(10)
        img.addBorderView(color: Color.CC328B9, width: 1)
        lbl.moveLabel(label: lbl)

    }
    
    func initCell(with cell: SportsItemModel){
        img.image = UIImage(named:cell.imgName)
        lbl.text = cell.titleName
    }

}
struct SportsItemModel{
    let imgName:String
    let titleName:String
}


