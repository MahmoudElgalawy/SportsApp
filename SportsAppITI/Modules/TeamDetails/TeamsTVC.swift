//
//  TeamsTVC.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit
import Kingfisher

class TeamsTVC: UITableViewCell {

    @IBOutlet weak var numPlayer: UILabel!
    
    @IBOutlet weak var agePlayer: UILabel!
    
    @IBOutlet weak var countryPlayer: UILabel!
    
    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var photoPlayer: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(data:Player){
        self.numPlayer.text = data.playerNumber
        self.namePlayer.text = data.playerName
        self.agePlayer.text = data.playerAge
        guard let country = data.playerCountry else{return}
        self.countryPlayer.text = country
        guard let image = data.playerImage else{return}
        let url = URL(string: image)
       photoPlayer.kf.setImage(with: url,placeholder: UIImage(systemName: "person"))
    }
}
