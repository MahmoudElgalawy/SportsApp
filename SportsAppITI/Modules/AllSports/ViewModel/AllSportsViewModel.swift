//
//  AllSportsViewModel.swift
//  SportsAppITI
//
//  Created by Engy on 8/18/24.
//

// AllSportsViewModel.swift
import Foundation

class AllSportsViewModel {

    // MARK: - Properties
    private(set) var sportsItems: [SportsItemModel] = []
    var isOrthogonalLayout = true
    var isFavorite = true

    // Closure for navigation
    var onNavigateToLeagues: ((SportsItemModel) -> Void)?

    init() {
        setupSportsItems()
    }

    private func setupSportsItems() {
        sportsItems = [
            SportsItemModel(imgName: "football", titleName: "Football"),
            SportsItemModel(imgName: "basket", titleName: "Basketball"),
            SportsItemModel(imgName: "cricket", titleName: "Cricket"),
            SportsItemModel(imgName: "tennisBalls", titleName: "Tennis")
        ]
    }

    func toggleLayout() {
        isOrthogonalLayout.toggle()
    }

    func getImageNameForLayoutButton() -> String {
        return isOrthogonalLayout ? "square.grid.2x2" : "list.bullet"
    }

    func handleItemSelection(at indexPath: IndexPath, completion: @escaping (Bool, SportsItemModel) -> Void) {
        let selectedItem = sportsItems[indexPath.row]
        ConnectivityService.shared.checkInternetConnection { isConnected in
            completion(isConnected, selectedItem)
        }
    }
    func navigateToLeagues(for selectedItem: SportsItemModel) {
            onNavigateToLeagues?(selectedItem)
        }
}
