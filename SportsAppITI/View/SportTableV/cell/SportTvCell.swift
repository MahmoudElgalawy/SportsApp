//
//  LeagueTVCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import UIKit
import Kingfisher

class SportTvCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var lbl: UILabel!
    @IBOutlet private var img: UIImageView!
    @IBOutlet private var backImg: UIImageView!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - UI Configuration
    private func configureUI() {
        mainView.addRadiusView(16)
        img.addRadiusView(20)
        img.addBorderView(color: Color.C01D681, width: 4)
        mainView.addBorderView(color: Color.C989898, width: 0.5)
        lbl.moveLabel(label: lbl)
        //rotateLabel(label: lbl)
        
        backImg.addRadiusView(20)
        img.animateImageView(imageView: img)
    }

    // MARK: - Selection Handling
    override var isSelected: Bool {
        didSet {
            //contentView.backgroundColor = isSelected ?UIColor.black : UIColor.white
        }
    }

    // MARK: - Configuration
    func configure(with cell: LeagueModel) {
        lbl.text = cell.leagueName
        img.kf.setImage(with: URL(string: cell.leagueLogo ?? ""), placeholder: UIImage(named: "No_image.svg"))
    }
}
