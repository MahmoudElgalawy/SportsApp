//
//  SportsCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class AllSportsCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var sportImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        sportImageView.layer.cornerRadius = 16
        sportImageView.layer.masksToBounds = true
        sportImageView.layer.borderWidth = 2
        sportImageView.layer.borderColor = UIColor(named: "#97C256")?.cgColor

        //animateImgView()
        aimationlabel()
    }

    private func aimationlabel() {
        titleLabel.moveLabel(label: titleLabel)
    }

    private func animateImgView() {
        sportImageView.animateImageView()
    }
    // MARK: - Configuration
    func configure(with model: SportsItemModel) {
        sportImageView.image = UIImage(named: model.imgName)
        titleLabel.text = model.titleName
    }
}

