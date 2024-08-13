//
//  LeagueDetailsVC.swift
//  SportsAppITI
//
//  Created by Engy on 8/12/24.
//

import UIKit

class LeagueDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet var imgNoData: UIImageView!
    
    @IBOutlet var collectionLeagueDet: UICollectionView!
    
    @IBOutlet var btnAddToFav: UIBarButtonItem!
    var upComing = [LeagueModel]()
    var latest = [EventModel]()
    var leagueID: Int!
    var teams = [String]()
    var nW : NWService?
    var sport: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                    switch sectionIndex {
                    case 0 :
                        return self.drawUpComingSection()
                    case 1 :
                        return self.drawLatestSection()
                    default:
                        return self.drawTeamsSection()
                    }
                }
        collectionLeagueDet.setCollectionViewLayout(layout, animated: true)
        
//        nW?.getAllData(sportName: .AllLeagues ,model: LeagueModelAPI.self) { result, error in
//            if let error = error {
//                print("Error fetching leagues: \(error)")
//                return
//            }
//            DispatchQueue.main.async {
//                self.upComing = result!.result
//                
//                print(self.upComing)
//                self.collectionLeagueDet.reloadData()
//            }
//        }
        
        collectionLeagueDet.delegate = self
        collectionLeagueDet.dataSource = self
        
    }
    
    func drawUpComingSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)) // Set the header size
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    
    func drawLatestSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
        
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension:  .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        if  upComing.count == 0 || latest.count == 0 {
//            collectionLeagueDet.isHidden = true
//            imgNoData.isHidden = false
//        }else{
            imgNoData.isHidden = true
            collectionLeagueDet.isHidden = false
//         }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 10
        case 1 :
            return 10
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0 :
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCVC", for: indexPath) as! LeaguesDetailsCVC
            //let event = upComing[indexPath.row]
//            cellA.setUpUpcoming(logo1: event.homeTeamLogo, name1: event.eventHomeTeam, logo2: event.awayTeamLogo, name2: event.eventAwayTeam, date: event.eventDate, time: event.eventTime)
            return cellA
        case 1 :
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaguesDetailsCVC", for: indexPath) as! LeaguesDetailsCVC
            //let event = upComing[indexPath.row]
//            cellB.setUpUpcoming(logo1: event.homeTeamLogo, name1: event.eventHomeTeam, logo2: event.awayTeamLogo, name2: event.eventAwayTeam, date: event.eventDate, time: event.eventTime)
            return cellB
        default:
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCVC", for: indexPath) as! TeamsCVC
            
            return cellC
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeagueDSecHed", for: indexPath) as! LeagueDSecHed
            
            switch indexPath.section {
            case 0:
                header.lblSectionHeader.text = "Up Coming Events"
                
            case 1:
                header.lblSectionHeader.text = "Latest Results"
            default:
                header.lblSectionHeader.text = "Teams"
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
    @IBAction func addToFav(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
