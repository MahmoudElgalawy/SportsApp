//
//  TeamsCVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 13/08/2024.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet var teamsImage: UIImageView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var teamsNamelbl: UILabel!

    // MARK: - Lifecycle
    override  func awakeFromNib() {
        super.awakeFromNib()
        configureUI()

    }
    // MARK: - UI Configuration
    private func configureUI() {
        mainView.layer.cornerRadius = 16
        mainView.layer.borderColor = UIColor(named: Color.CD9D9D9.rawValue)?.cgColor
        mainView.layer.borderWidth = 1

        teamsImage.layer.cornerRadius = 10
        }
    
    // MARK: - Configuration
    func configure(with Cell:TeamModel){
        let url = URL(string: Cell.teamLogo ?? "")
        teamsImage.kf.setImage(with:url, placeholder: UIImage(named: "team"))
        teamsNamelbl.text = Cell.teamName
    }

}
