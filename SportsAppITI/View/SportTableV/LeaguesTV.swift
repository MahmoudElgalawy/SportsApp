//
//  LeagueVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class LeaguesTV: UIViewController {

    let activityIndicator = UIActivityIndicatorView(style: .large)
    var sportsName:String?
    let networkManger = NWService.shared

    var footballLeagues: [LeagueModel] = []
    @IBOutlet var leagueTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTV.register(UINib(nibName: "SportTvCell", bundle: nil), forCellReuseIdentifier: "SportTvCell")
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        getAllLeagues()
    }
}
extension LeaguesTV {
   func getAllLeagues(){
       activityIndicator.startAnimating()
       networkManger.getAllData(sportName:.AllLeagues, model: LeagueModelAPI.self) {[weak self] result, error in
           self?.activityIndicator.stopAnimating()
                   if let error = error {
                       print("Error fetching leagues: \(error)")
                       return
                   }
                   DispatchQueue.main.async {
                       self!.footballLeagues = result!.result
                       self?.activityIndicator.stopAnimating()
                       self!.leagueTV.reloadData()
                   }
       
               }
    }
}
extension LeaguesTV:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footballLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportTvCell") as! SportTvCell
        cell.configure(with:footballLeagues[indexPath.row])
        return cell
    }
}

extension LeaguesTV:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsVC
           //vc.leagueID = footballLeagues[indexPath.row].leagueKey
           self.navigationController?.pushViewController(vc, animated: true)
       }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.contentView.backgroundColor = UIColor.white
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: 30)
        cell.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveEaseIn], animations: {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }, completion: nil)
    }

}

