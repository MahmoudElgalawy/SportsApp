//
//  AllSportsViewModel.swift
//  SportsAppITI
//
//  Created by Engy on 8/18/24.
//

import Foundation

class AllSportsViewModel {

    // MARK: - Properties
    private(set) var sportsItems: [SportsItemModel] = []
    private var isOrthogonalLayout: Bool = true

    // MARK: - Initialization
    init() {
        setupSportsItems()
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

    func toggleLayout() {
        isOrthogonalLayout.toggle()
    }

    var layoutType: LayoutType {
        return isOrthogonalLayout ? .orthogonal : .list
    }

    // MARK: - Layout Handling
    enum LayoutType {
        case orthogonal
        case list
    }
}

