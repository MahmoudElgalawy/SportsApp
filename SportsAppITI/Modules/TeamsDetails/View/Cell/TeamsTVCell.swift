//
//  TeamsTVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit
import Kingfisher

class TeamsTVCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerRoleLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPhotoImageView: UIImageView!

    // MARK: - Lifecycle

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
    // MARK: - UI Configuration
    private func configureUI() {
        mainView.layer.cornerRadius = 16
        mainView.layer.borderColor = UIColor(named: "#121212")?.cgColor
        mainView.layer.borderWidth = 0.5

        playerPhotoImageView.layer.borderColor = UIColor(named: "#D9D9D9")?.cgColor
        playerPhotoImageView.layer.borderWidth = 0.5
        DispatchQueue.main.async {
            self.playerPhotoImageView.layer.cornerRadius = self.playerPhotoImageView.frame.height / 2
        }
    }
    // MARK: - Configuration
    func configure(with player: Player) {
        playerNumberLabel.text = "Captain: \(player.playerIsCaptain ?? "0")"
        playerNameLabel.text = "Name: \(player.playerName)"
        playerRoleLabel.text = "Type: \(player.playerType ?? "0")"

        if let imageUrl = player.playerImage {
            playerPhotoImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "person"))
        }
    }
}
