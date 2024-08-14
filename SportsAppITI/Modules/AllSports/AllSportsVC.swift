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

    // MARK: - Outlets
    @IBOutlet private var layoutToggleButton: UIBarButtonItem!
    @IBOutlet private var sportsCollectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSportsItems()
    }

    // MARK: - Setup Methods
    private func setupSportsItems() {
        sportsItems = [
            SportsItemModel(imgName: "football", titleName: "Football"),
            SportsItemModel(imgName: "basketball", titleName: "Basketball"),
            SportsItemModel(imgName: "cricket", titleName: "Cricket"),
            SportsItemModel(imgName: "tennis", titleName: "Tennis")
        ]
    }
    func checkInternetConnection(completion: @escaping (Bool) -> Void) {
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                DispatchQueue.main.async {
                    completion(path.status == .satisfied)
                    monitor.cancel()
                }
            }
            monitor.start(queue: .main)
        }


    // MARK: - Actions
    @IBAction private func layoutToggleButtonPressed(_ sender: UIBarButtonItem) {
        isOrthogonalLayout.toggle()
        layoutToggleButton.image = UIImage(systemName: isOrthogonalLayout ? "square.grid.2x2" : "list.bullet")
        sportsCollectionView.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isOrthogonalLayout ? orthogonalLayoutSize(for: collectionView) : listLayoutSize(for: collectionView)
    }

    private func orthogonalLayoutSize(for collectionView: UICollectionView) -> CGSize {
        let numberOfCellsInRow: CGFloat = 2
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10

        let totalSpacing = flowLayout.minimumInteritemSpacing * (numberOfCellsInRow - 1)
        let availableWidth = collectionView.bounds.width - totalSpacing
        let width = availableWidth / numberOfCellsInRow

        return CGSize(width: width - 10, height: width)
    }

    private func listLayoutSize(for collectionView: UICollectionView) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        return CGSize(width: collectionViewWidth - 10, height: collectionViewHeight / 4 - 10)
    }
}

// MARK: - UICollectionViewDelegate
extension AllSportsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkInternetConnection { [weak self] isConnected in
            if isConnected {
                guard let leaguesVC = self?.storyboard?.instantiateViewController(withIdentifier: "LeaguesTV") as? LeaguesTV else { return }
                let title = self!.sportsItems[indexPath.row].titleName
                leaguesVC.sportName = title.lowercased()
                leaguesVC.title = title
                self?.navigationController?.pushViewController(leaguesVC, animated: true)
            } else {
                let alert = UIAlertController(title: "No internet available!", message: "check connection and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
}

