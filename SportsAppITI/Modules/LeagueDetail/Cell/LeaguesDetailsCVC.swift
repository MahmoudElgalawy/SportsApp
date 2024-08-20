//
//  CollectionViewCell.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 13/08/2024.
//

import UIKit
import Kingfisher

class LeaguesDetailsCVC: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var homeTeamLogo: UIImageView!
    @IBOutlet var homeTeamNameLabel: UILabel!
    @IBOutlet var awayTeamLogo: UIImageView!
    @IBOutlet var awayTeamNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    // MARK: - UI Configuration
    private func configureUI() {
        backImageView.layer.cornerRadius = 16

    }

    // MARK: - Configuration
    func configure(with event:EventModel) {
        if let homeTeamLogoURL = URL(string: event.homeTeamLogo ?? "") {
            homeTeamLogo.kf.setImage(with: homeTeamLogoURL, placeholder: UIImage(named: "team"))
        }
        if let awayTeamLogoURL = URL(string: event.awayTeamLogo ?? "") {
            awayTeamLogo.kf.setImage(with: awayTeamLogoURL, placeholder: UIImage(named: "team"))
        }

        homeTeamNameLabel.text = event.eventHomeTeam
        awayTeamNameLabel.text = event.eventAwayTeam
        dateLabel.text = event.eventDate
        timeLabel.text = event.eventTime
        resultLabel.isHidden = event.eventFinalResult == "-"
        resultLabel.text = event.eventFinalResult
    }

}
