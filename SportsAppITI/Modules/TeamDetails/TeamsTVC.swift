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

    
    
    func configureCell(data: Player) {
        self.numPlayer.text = data.playerNumber
        self.namePlayer.text = data.playerName
        self.agePlayer.text = data.playerAge
        self.countryPlayer.text = data.playerCountry ?? "Unknown"
        
        if let image = data.playerImage {
            guard let url = URL(string: image) else {
                print("Invalid image URL: \(image)")
                return
            }
            print("Loading image from URL: \(url)")
            photoPlayer.kf.setImage(with: url, placeholder: UIImage(systemName: "person"), options: nil, completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Successfully loaded image: \(value.image)")
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                }
            })
        } else {
            photoPlayer.image = UIImage(systemName: "person")
        }
    }
}
