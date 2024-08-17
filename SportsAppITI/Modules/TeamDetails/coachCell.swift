//
//  coachCell.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit

class coachCell: UITableViewCell {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(coach:Coach){
        self.name.text = coach.coachName
        guard let country = coach.coachCountry else{return}
        self.country.text = country
        guard let age = coach.coachAge else{return}
        self.age.text = String(age)
    }
    
}
