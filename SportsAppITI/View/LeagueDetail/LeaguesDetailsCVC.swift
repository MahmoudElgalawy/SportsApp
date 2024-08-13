//
//  CollectionViewCell.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 13/08/2024.
//

import UIKit
import Kingfisher

class LeaguesDetailsCVC: UICollectionViewCell {
    @IBOutlet var logoTeam1: UIImageView!
    
    @IBOutlet var nameTeam1: UILabel!
    
    @IBOutlet var logoTeam2: UIImageView!
    
    @IBOutlet var nameTeam2: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var lblResult: UILabel!
    
    
    func setUpUpcoming(logo1:String,name1:String,logo2:String,name2:String,date:String,time:String){
        
        let url1 = URL(string: logo1)
        let url2 = URL(string: logo2)
        self.logoTeam1.kf.setImage(with: url1,placeholder: UIImage(named: "6"))
        self.nameTeam1.text = name1
        self.logoTeam2.kf.setImage(with: url2,placeholder: UIImage(named: "6"))
        self.nameTeam2.text = name2
        self.lblDate.text = date
        self.lblTime.text = time
        self.lblResult.isHidden = true
    }
    
    func setUpLatest(logo1:String,name1:String,logo2:String,name2:String,date:String,time:String,result:String){
        
        let url1 = URL(string: logo1)
        let url2 = URL(string: logo2)
        self.logoTeam1.kf.setImage(with: url1,placeholder: UIImage(named: "6"))
        self.nameTeam1.text = name1
        self.logoTeam2.kf.setImage(with: url2,placeholder: UIImage(named: "6"))
        self.nameTeam2.text = name2
        self.lblDate.text = date
        self.lblTime.text = time
        self.lblResult.isHidden = false
        self.lblResult.text = result
    }
    
    
}
