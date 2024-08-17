//
//  LeagueVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

//
//  LeagueVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
import WebKit

class LeaguesTV: UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let networkManager = NetworkService.shared
    private var footballLeagues = [LeagueModel]()
    private var webView: WKWebView?
    var sportName: String?

    // MARK: - Outlets
    @IBOutlet private var leagueTableView: UITableView!
    @IBOutlet private var noDataImg: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAllLeagues()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupActivityIndicator()
        leagueTableView.dataSource = self
        leagueTableView.delegate = self
    }

    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }

    // MARK: - Network Call
    private func fetchAllLeagues() {
        guard let sportName = sportName else { return }
        activityIndicator.startAnimating()
        networkManager.fetchData(from: .getAllLeagues(sportsName: sportName), model: LeagueModelAPI.self) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let error = error {
                    print("Error fetching leagues: \(error.localizedDescription)")
                    return
                }
                self?.footballLeagues = result?.result ?? []
                self?.leagueTableView.reloadData()
            }
        }
    }

    // MARK: - Actions
    @objc private func dismissWebViewController() {
        dismiss(animated: true)
    }

    private func showYouTubeVideo(urlString: String) {
        let webViewController = UIViewController()
        webViewController.view.backgroundColor = .white

        // Initialize the WKWebView
        webView = WKWebView(frame: webViewController.view.bounds)
        webView?.navigationDelegate = self
        webViewController.view.addSubview(webView!)

        // Load the YouTube URL
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView?.load(request)
        }

        // Add a back button
        let backButton = UIButton(frame: CGRect(x: 15, y: 40, width: 100, height: 40))
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(dismissWebViewController), for: .touchUpInside)
        webViewController.view.addSubview(backButton)

        present(webViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension LeaguesTV: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footballLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SportTvCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(with: footballLeagues[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeaguesTV: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails",
           let detailsVC = segue.destination as? LeagueDetailsVC,
           let row = sender as? Int {
            detailsVC.leagueID = footballLeagues[row].leagueKey
            detailsVC.leagueTitle = footballLeagues[row].leagueName
            detailsVC.league = self.footballLeagues[row]
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.animateSlideAndFadeIn()
    }
}

// MARK: - SportTvCellDelegate
extension LeaguesTV: SportTvCellDelegate {
    func didPressYouTubeButton(with urlString: String) {
        showYouTubeVideo(urlString: urlString)
    }
}
