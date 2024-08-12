//
//  LeagueTVCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import UIKit
import Kingfisher

class SportTvCell: UITableViewCell {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var lbl: UILabel!
    @IBOutlet var img: UIImageView!

    @IBOutlet var backImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addRadiusView(16)
        img.animateImageView(imageView: img)
        mainView.addBorderView(color: Color.C01D681, width: 0.5)

        img.addRadiusView(20)
        img.addBorderView(color: Color.C01D681, width: 4)
        lbl.moveLabel(label: lbl)
        backImg.addRadiusView(20)


    }
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? UIColor.black : UIColor.white
            }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func initWithCell(cell:LeagueModel){
        lbl.text = cell.countryName
        img.kf.setImage(with: URL(string: cell.leagueLogo ?? ""),placeholder: UIImage(named: "close-button"))



    }

}
