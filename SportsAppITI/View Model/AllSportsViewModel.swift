//
//  AllSportsViewModel.swift
//  SportsAppITI
//
//  Created by Engy on 8/13/24.
//

import Foundation
class AllSportsViewModel {
    var sportsItems: [SportsItemModel] = []
    private let networkManager = NWService.shared
    var reloadCollectionViewHandler:(()->())={}

    init(sportsItems: [SportsItemModel]){
        self.sportsItems = sportsItems
        loadSportsItems()

    }
    
    func loadSportsItems(){
        reloadCollectionViewHandler()
    }



}
