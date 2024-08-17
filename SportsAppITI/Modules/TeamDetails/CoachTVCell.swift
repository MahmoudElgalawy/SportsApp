//
//  coachCell.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 16/08/2024.
//

import UIKit

class CoachTVCell: UITableViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }


    func configureUI() {
        mainView.layer.cornerRadius = 20
        mainView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        mainView.layer.borderWidth = 0.5

    }

    func configure(with cell :Coach){
        self.name.text = cell.coachName
        guard let country = cell.coachCountry else{return}
        self.country.text = country
        guard let age = cell.coachAge else{return}
        self.age.text = String(age)
    }
    
}
