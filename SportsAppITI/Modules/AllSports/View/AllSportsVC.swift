//
//  SportsCell.swift
//  SportsAppITI
//
//  Created by Engy on 8/11/24.
//

import UIKit

class AllSportsVC: UIViewController {

    // MARK: - Properties
    private var viewModel = AllSportsViewModel()

    // MARK: - Outlets
    @IBOutlet private var layoutToggleButton: UIBarButtonItem!
    @IBOutlet private var sportsCollectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        updateLayoutButtonImage()
    }

    // MARK: - Setup Methods
    private func configureCollectionView() {
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
    }

    private func updateLayoutButtonImage() {
        let imageName = viewModel.getImageNameForLayoutButton()
        layoutToggleButton.image = UIImage(systemName: imageName)
    }

    // MARK: - Actions
    @IBAction private func layoutToggleButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.toggleLayout()
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
        return viewModel.sportsItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AllSportsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.sportsItems[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AllSportsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.isOrthogonalLayout ? orthogonalLayoutSize(for: collectionView) : listLayoutSize(for: collectionView)
    }

    private func orthogonalLayoutSize(for collectionView: UICollectionView) -> CGSize {
        let numberOfCellsInRow: CGFloat = 2
        let itemSpacing: CGFloat = 10
        let itemPadding: CGFloat = 10

        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.minimumInteritemSpacing = itemSpacing

        let totalSpacing = flowLayout.minimumInteritemSpacing * (numberOfCellsInRow - 1)
        let availableWidth = collectionView.bounds.width - totalSpacing
        let width = availableWidth / numberOfCellsInRow

        return CGSize(width: width - itemPadding, height: width + 50)
    }

    private func listLayoutSize(for collectionView: UICollectionView) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        let listItemHeightRatio: CGFloat = 4
        let itemSpacing: CGFloat = 10
        let itemHeight = collectionViewHeight / listItemHeightRatio - itemSpacing

        return CGSize(width: collectionViewWidth - 10, height: itemHeight)
    }
}

// MARK: - UICollectionViewDelegate
extension AllSportsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleItemSelection(at: indexPath) { [weak self] isConnected, selectedItem in
            guard let self = self else { return }
            if isConnected {
                self.navigateToLeaguesVC(for: selectedItem)
            } else {
                self.presentNoInternetAlert()
            }
        }
    }

    private func navigateToLeaguesVC(for selectedItem: SportsItemModel) {
        guard let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesTV") as? AllLeaguesVC else { return }
        let title = selectedItem.titleName
        leaguesVC.title = title
        leaguesVC.viewModel.isFavorite = false
        leaguesVC.viewModel.sportName = title.lowercased()

        navigationController?.pushViewController(leaguesVC, animated: true)
    }

    private func presentNoInternetAlert() {
        let alert = UIAlertController(title: "No internet available!", message: "Check connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
