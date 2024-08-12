//
//  LeagueVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
import Network

class SportTV: UIViewController {

    let activityIndicator = UIActivityIndicatorView(style: .large)

    let networkManger = NWService.shared
    let monitor = NWPathMonitor()

    var footballLeagues: [LeagueModel] = []
    @IBOutlet var leagueTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Football"
        leagueTV.register(UINib(nibName: "SportTvCell", bundle: nil), forCellReuseIdentifier: "SportTvCell")
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)


        setupNetworkMonitoring()
    }


}
extension SportTV {
    private func setupNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    print("Internet is available")
                    self?.fetchDataFromNetwork()
                } else {
                    print("No internet connection")
                    //self?.fetchMoviesFromCoreData()
                }
                self?.monitor.cancel()
            }
        }
        monitor.start(queue:.main)
    }

    private func fetchMoviesFromCoreData() {

    }

   func fetchDataFromNetwork(){
       activityIndicator.startAnimating()

       networkManger.getAllData(sportName:Sports.footBall.rawValue, model: LeagueModelAPI.self) {[weak self] result, error in
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
extension SportTV:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footballLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportTvCell") as! SportTvCell
        cell.initWithCell(cell: footballLeagues[indexPath.row])
        return cell
    }



}

extension SportTV:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsVC
           //vc.leagueID = footballLeagues[indexPath.row].leagueKey
           self.navigationController?.pushViewController(vc, animated: true)
       }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.contentView.backgroundColor = UIColor.white // Change to your default color
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

