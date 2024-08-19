//
//  LeagueTVCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import UIKit
import Kingfisher

protocol SportTvCellDelegate: AnyObject {
    func didPressYouTubeButton(with urlString: String)
}

class SportTvCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var leagueNameLabel: UILabel!
    @IBOutlet private var leagueImageView: UIImageView!
    @IBOutlet private var backgroundImageView: UIImageView!

    // MARK: - Properties
    weak var delegate: SportTvCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.systemBackground : UIColor.systemBackground
        }
    }
   

    // MARK: - UI Configuration
    private func configureUI() {

        leagueImageView.layer.cornerRadius = leagueImageView.frame.height / 2
        leagueImageView.clipsToBounds = true
        leagueImageView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        leagueImageView.layer.borderWidth = 0.25

        mainView.layer.cornerRadius = 16
        mainView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
        mainView.layer.borderWidth = 0.25
        mainView.clipsToBounds = true

        backgroundImageView.layer.cornerRadius = mainView.frame.width / 2



    }



    // MARK: - Configuration
    func configure(with league: LeagueModel) {
        leagueNameLabel.text = league.leagueName
        if let imageUrl = URL(string: league.leagueLogo ?? "") {
            leagueImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "no_img"))
        } else {
            leagueImageView.image = UIImage(named: "no_img")
        }
        leagueImageView.animateImageView(imageView: leagueImageView)
        leagueImageView.animateImageView()
    }

    // MARK: - YouTube Actions
    @IBAction private func youtubeButtonPressed(_ sender: UIButton) {
        if let leagueName = leagueNameLabel.text, let searchURL = createYouTubeSearchURL(for: leagueName) {
            delegate?.didPressYouTubeButton(with: searchURL.absoluteString)
        }
    }

    private func createYouTubeSearchURL(for query: String) -> URL? {
        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.youtube.com/results?search_query=\(formattedQuery)&sp=EgIQAg%253D%253D"
        return URL(string: urlString)
    }
}
