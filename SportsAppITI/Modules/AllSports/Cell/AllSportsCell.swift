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

    // MARK: - Setup Methods
    private func setupUI() {
        sportImageView.layer.cornerRadius = 10
        sportImageView.layer.masksToBounds = true
        sportImageView.layer.borderWidth = 1
        sportImageView.layer.borderColor = UIColor(named: "CC328B9")?.cgColor

        animateImageView()
        aimationlabel()
    }

    private func aimationlabel() {
        titleLabel.moveLabel(label: titleLabel)
    }

    private func animateImageView() {
        animateImageView(imageView: sportImageView)
    }

    // MARK: - Configuration
    func configure(with model: SportsItemModel) {
        sportImageView.image = UIImage(named: model.imgName)
        titleLabel.text = model.titleName
    }
}

