//
//  CollectionViewCell.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 13/08/2024.
//

import UIKit
import Kingfisher

class LeaguesDetailsCVC: UICollectionViewCell {
    @IBOutlet var backImage: UIImageView!
    @IBOutlet var logoTeam1: UIImageView!
    @IBOutlet var nameTeam1: UILabel!
    @IBOutlet var logoTeam2: UIImageView!
    @IBOutlet var nameTeam2: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backImage.layer.cornerRadius = 16
    }


    func confinge(with cell:EventModel){

        let url1 = URL(string: cell.homeTeamLogo ?? "")
        let url2 = URL(string: cell.awayTeamLogo ?? "")
        self.logoTeam1.kf.setImage(with: url1,placeholder: UIImage(named: "6"))
        self.nameTeam1.text = cell.eventHomeTeam
        self.logoTeam2.kf.setImage(with: url2,placeholder: UIImage(named: "6"))
        self.nameTeam2.text = cell.eventAwayTeam
        self.lblDate.text = cell.eventDate
        self.lblTime.text = cell.eventTime
        if cell.eventFinalResult == "-" {
            self.lblResult.isHidden = true

        } else {
            self.lblResult.isHidden = false
            self.lblResult.text = cell.eventFinalResult
        }
    }

}
