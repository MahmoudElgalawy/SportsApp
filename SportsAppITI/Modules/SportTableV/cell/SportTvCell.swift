//
//  LeagueTVCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import UIKit
import Kingfisher
import WebKit

protocol SportTvCellDelegate: AnyObject {
    func didPressYouTubeButton(with urlString: String)
}

class SportTvCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var lbl: UILabel!
    @IBOutlet private var img: UIImageView!
    @IBOutlet private var backImg: UIImageView!
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
        img.layer.cornerRadius = img.frame.height / 2
           img.clipsToBounds = true
           img.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
           img.layer.borderWidth = 0.5

           // Apply rounded corners to other views
           mainView.layer.cornerRadius = 16
           mainView.layer.borderColor = UIColor(named: Color.C121212.rawValue)?.cgColor
           mainView.layer.borderWidth = 0.5
           mainView.clipsToBounds = true

           backImg.layer.cornerRadius = mainView.frame.width / 2

            img.animateImageView()
    }

    // MARK: - Configuration
    func configure(with cell: LeagueModel) {
        lbl.text = cell.leagueName
        let imageUrl = URL(string: cell.leagueLogo ?? "")
        img.kf.setImage(with: imageUrl, placeholder: UIImage(named: "no_img"))
    }

    // MARK: - YouTube Actions
    @IBAction func youtubeBtnPressed(_ sender: Any) {
        // Create a search URL based on the league name
        if let leagueName = lbl.text, let searchURL = createYouTubeSearchURL(for: leagueName) {
            delegate?.didPressYouTubeButton(with: searchURL.absoluteString)
        }
    }

    private func createYouTubeSearchURL(for query: String) -> URL? {
        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.youtube.com/results?search_query=\(formattedQuery)/channel"
        return URL(string: urlString)
    }
}
