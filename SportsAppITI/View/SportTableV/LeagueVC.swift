//
//  LeagueVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class SportSportTV: UIViewController {
    var array:[LeagueModel] = []

    @IBOutlet var leagueTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTV.register(UINib(nibName: "LeagueTVCell", bundle: nil), forCellReuseIdentifier: "LeagueTVCell")

    }
    

}
extension SportSportTV:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTVCell") as! LeagueTVCell
         cell.initWithCell(cell: array[indexPath.row])
        return cell
    }



}

extension SportSportTV:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.transform = CGAffineTransform(translationX: 0, y: 30)
        cell.alpha = 0

        UIView.animate(withDuration: 0.6, delay: 0, options: [.beginFromCurrentState], animations: {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }, completion: nil)
    }

}

