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
    let viewModel = LeaguesViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var webView: WKWebView?

    // MARK: - Outlets
    @IBOutlet private var leagueTableView: UITableView!
    @IBOutlet private var noDataImg: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchLeagues()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLeagues()
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

    // MARK: - Data Fetching
    private func fetchLeagues() {
        viewModel.fetchLeagues { [weak self] hasData in
            self?.handeError(hasData: hasData)
            self?.leagueTableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }

    private func handeError(hasData: Bool) {
        noDataImg.isHidden = hasData
        leagueTableView.isHidden = !hasData
    }

    // MARK: - Actions
    @objc private func dismissWebViewController() {
        dismiss(animated: true)
    }

    private func showYouTubeVideo(urlString: String) {
        let webViewController = UIViewController()
        webViewController.view.backgroundColor = .white
        webView = WKWebView(frame: webViewController.view.bounds)
        webView?.navigationDelegate = self
        webViewController.view.addSubview(webView!)

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView?.load(request)
        }

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
        return viewModel.footballLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SportTvCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(with: viewModel.footballLeagues[indexPath.row])
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
            detailsVC.leagueID = viewModel.footballLeagues[row].leagueKey
            detailsVC.leagueTitle = viewModel.footballLeagues[row].leagueName
            detailsVC.league = viewModel.footballLeagues[row]
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.animateSlideAndFadeIn()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.isFavorite
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteLeague(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handeError(hasData: !viewModel.footballLeagues.isEmpty)
        }
    }
}

// MARK: - SportTvCellDelegate
extension LeaguesTV: SportTvCellDelegate {
    func didPressYouTubeButton(with urlString: String) {
        showYouTubeVideo(urlString: urlString)
    }
}
