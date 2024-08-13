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
        mainView.layer.cornerRadius = 16
        img.layer.cornerRadius = 20
        img.layer.borderColor = UIColor(named:Color.C121212.rawValue)?.cgColor
        img.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor(named:Color.C121212.rawValue)?.cgColor
        mainView.layer.borderWidth = 0.5
        backImg.layer.cornerRadius = 20

        img.animateImageView()
    }

    // MARK: - Configuration
    func configure(with cell: LeagueModel) {
        lbl.text = cell.leagueName
        let imageUrl = URL(string: cell.leagueLogo ?? "")
        img.kf.setImage(with: imageUrl, placeholder: UIImage(named: "no_img"))
    }
}
private extension UIImageView {
    func animateImageView() {
        UIView.animate(withDuration: 1.0) {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 1.0) {
            self.transform = CGAffineTransform.identity
        }
    }
}
