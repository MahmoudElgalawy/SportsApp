//
//  TeamsTVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit
import Kingfisher

class TeamsTVCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerRoleLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPhotoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        animateImage()
    }

    private func animateImage() {
        playerPhotoImageView.animateSlideAndFadeIn()
    }
    private func animateImgView() {
        playerPhotoImageView.animateImageView()
    }

    private func configureUI() {
        mainView.layer.cornerRadius = 16
        mainView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        mainView.layer.borderWidth = 0.5

        playerPhotoImageView.layer.cornerRadius = 16
        playerPhotoImageView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        playerPhotoImageView.layer.borderWidth = 0.2
    }

    func configure(with player: Player) {
        playerNumberLabel.text = "Captain: \(player.playerIsCaptain ?? "0")"
        playerNameLabel.text = "Name: \(player.playerName)"
        playerRoleLabel.text = "Type: \(player.playerType ?? "0")"

        if let imageUrl = player.playerImage {
            playerPhotoImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "person"))
        }
    }
}
