//
//  TeamsCVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 13/08/2024.
//

import UIKit
import Kingfisher

class TeamsCVC: UICollectionViewCell {
    @IBOutlet var imgTeams: UIImageView!
    @IBOutlet var lblTeamsName: UILabel!
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        imgTeams.layer.cornerRadius = 20
    }

    func confinge(with Cell:TeamModel){
        let url = URL(string: Cell.homeTeamLogo ?? "")
        imgTeams.kf.setImage(with: url)
        lblTeamsName.text = Cell.eventHomeTeam
    }

}
