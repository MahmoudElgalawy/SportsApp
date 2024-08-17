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

    }

    func configureUI() {
        photoPlayer.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 20
        mainView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        mainView.layer.borderWidth = 0.5
    }
    func configure(with cell: Player) {
        self.numPlayerLbl.text = cell.playerNumber
        self.namePlayerLbl.text = cell.playerName
        self.rolePlayerLbl.text = cell.playerType ?? ""

        photoPlayer.kf.setImage(with:URL(string: cell.playerImage ?? ""),placeholder: UIImage(named: "no_img"))


    }
}
