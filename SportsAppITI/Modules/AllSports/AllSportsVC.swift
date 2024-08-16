//
//  SportsCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit
import Network

class AllSportsVC: UIViewController {

    // MARK: - Properties
    private var isOrthogonalLayout = true
    private var sportsItems:[SportsItemModel] = []
    private var networkManger = NetworkService.shared
    private var connectivityChecking = ConnectivityService.shared


    // MARK: - Outlets
    @IBOutlet private var layoutToggleButton: UIBarButtonItem!
    @IBOutlet private var sportsCollectionView: UICollectionView!

    // MARK: - Initialization


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSportsItems()
        configureCollectionView()
    }
    // MARK: - Setup Methods
    private func setupSportsItems() {
        sportsItems = [
            SportsItemModel(imgName: "football", titleName: "Football"),
            SportsItemModel(imgName: "basket", titleName: "Basketball"),
            SportsItemModel(imgName: "cricket", titleName: "Cricket"),
            SportsItemModel(imgName: "tennisBalls", titleName: "Tennis")
        ]
    }
    private func configureCollectionView() {
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
    }

    private func updateLayoutButtonImage() {
        let imageName = isOrthogonalLayout ? "square.grid.2x2" : "list.bullet"
        layoutToggleButton.image = UIImage(systemName: imageName)
    }


    // MARK: - Actions
    @IBAction private func layoutToggleButtonPressed(_ sender: UIBarButtonItem) {
        isOrthogonalLayout.toggle()
        updateLayoutButtonImage()
        animateLayoutTransition()
    }
    private func animateLayoutTransition() {
        UIView.animate(withDuration: 0.4) {

            self.sportsCollectionView.animateCellsSlide()
            self.sportsCollectionView.reloadData()
            self.sportsCollectionView.layoutIfNeeded()
        }

    }


}

// MARK: - UICollectionViewDataSource
extension AllSportsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AllSportsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: sportsItems[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AllSportsVC: UICollectionViewDelegateFlowLayout {
    private enum LayoutConstants {
        static let orthogonalNumberOfCellsInRow: CGFloat = 2
        static let itemSpacing: CGFloat = 10
        static let listItemHeightRatio: CGFloat = 4
        static let itemPadding: CGFloat = 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isOrthogonalLayout ? orthogonalLayoutSize(for: collectionView) : listLayoutSize(for: collectionView)
    }

    private func orthogonalLayoutSize(for collectionView: UICollectionView) -> CGSize {
        let numberOfCellsInRow = LayoutConstants.orthogonalNumberOfCellsInRow
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = LayoutConstants.itemSpacing
        flowLayout.minimumInteritemSpacing = LayoutConstants.itemSpacing

        let totalSpacing = flowLayout.minimumInteritemSpacing * (numberOfCellsInRow - 1)
        let availableWidth = collectionView.bounds.width - totalSpacing
        let width = availableWidth / numberOfCellsInRow

        return CGSize(width: width - LayoutConstants.itemPadding, height: width+50)
    }

    private func listLayoutSize(for collectionView: UICollectionView) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        let itemHeight = collectionViewHeight / LayoutConstants.listItemHeightRatio - LayoutConstants.itemSpacing

        return CGSize(width: collectionViewWidth - LayoutConstants.itemPadding-10, height: itemHeight)
    }
}

// MARK: - UICollectionViewDelegate
extension AllSportsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        connectivityChecking.checkInternetConnection { [weak self] isConnected in
            guard let self = self else { return }
            self.handleInternetConnection(isConnected, forItemAt: indexPath)
        }
    }

    private func handleInternetConnection(_ isConnected: Bool, forItemAt indexPath: IndexPath) {
        if isConnected {
            navigateToLeaguesVC(forItemAt: indexPath)
        } else {
            presentNoInternetAlert()
        }
    }

    private func navigateToLeaguesVC(forItemAt indexPath: IndexPath) {
        guard let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesTV") as? LeaguesTV else { return }
        let title = sportsItems[indexPath.row].titleName
        leaguesVC.sportName = title.lowercased()
        leaguesVC.title = title
        navigationController?.pushViewController(leaguesVC, animated: true)
    }

    private func presentNoInternetAlert() {
        let alert = UIAlertController(title: "No internet available!", message: "Check connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


