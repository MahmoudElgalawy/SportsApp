//
//  TeamsTVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit
import Kingfisher

class TeamsTVCell: UITableViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var numPlayerLbl: UILabel!
    @IBOutlet weak var rolePlayerLbl: UILabel!
    @IBOutlet weak var namePlayerLbl: UILabel!
    @IBOutlet weak var photoPlayer: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        animateImgView()
    }

    private func animateImgView() {
        photoPlayer.animateSlideAndFadeIn()
    }

    func configureUI() {

        mainView.layer.cornerRadius = 10
        mainView.layer.borderColor = UIColor(named:Color.C121212.rawValue)?.cgColor
        mainView.layer.borderWidth = 0.2
        photoPlayer.layer.cornerRadius = 10
        photoPlayer.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        photoPlayer.layer.borderWidth = 0.5



    }
    func configure(with cell: Player) {
        self.numPlayerLbl.text = "Captain: \(cell.playerIsCaptain)"
        self.namePlayerLbl.text = "Name: \(cell.playerName)"
        self.rolePlayerLbl.text = "Type: \(cell.playerType ?? "0")"

        photoPlayer.kf.setImage(with:URL(string: cell.playerImage ?? ""),placeholder: UIImage(named: "no_img"))


    }
}
