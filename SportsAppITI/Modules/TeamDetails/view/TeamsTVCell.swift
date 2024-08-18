//
//  TeamsTVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit
import Kingfisher

class TeamsTVCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var Assits: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet var NamePlayer: UILabel!
    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var NumPlayer: UILabel!
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
        self.NamePlayer.text = cell.playerName
        self.NumPlayer.text = cell.playerNumber ?? " ! "
        self.Age.text = "Age: \(cell.playerAge ?? "unknowen")"
        self.goals.text = "Goals: \(cell.playerGoals ?? "0")"
        self.Assits.text =  "Assits: \(cell.playerAssists ?? "0")"
        self.position.text = "Position: \(cell.playerType ?? "unknown")"
        photoPlayer.kf.setImage(with:URL(string: cell.playerImage ?? ""),placeholder: UIImage(named: "person"))


    }
}
