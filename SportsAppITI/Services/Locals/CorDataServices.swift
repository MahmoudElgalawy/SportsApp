//
//  LocalServices.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 17/08/2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }

    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // Create a new league and save it
    func storeLeague(_ league: LeagueModel) {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", league.leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.isEmpty {
                let leagueEntity = FavLeagues(context: managedContext)
                leagueEntity.leagueKey = Int32(league.leagueKey)
                leagueEntity.leagueName = league.leagueName
                leagueEntity.leagueLogo = league.leagueLogo
                leagueEntity.leagueYear = league.leagueYear
                leagueEntity.countryKey = Int32(league.countryKey ?? 0)
                leagueEntity.countryName = league.countryName
                leagueEntity.countryLogo = league.countryLogo

                saveContext()
                print("League saved successfully.")
            } else {
                print("League already exists.")
            }
        } catch {
            print("Error fetching leagues: \(error)")
        }
    }

    // Fetch all leagues
    func fetchLeagues() -> [LeagueModel] {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        var leaguesArr = [LeagueModel]()

        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedLeague in results {
                let leagueKey = Int(managedLeague.leagueKey)
                let leagueName = managedLeague.leagueName ?? ""
                let leagueLogo = managedLeague.leagueLogo
                let leagueYear = managedLeague.leagueYear
                let countryKey = Int(managedLeague.countryKey)
                let countryName = managedLeague.countryName
                let countryLogo = managedLeague.countryLogo

                let league = LeagueModel(leagueKey: leagueKey, leagueName: leagueName, countryKey: countryKey, countryName: countryName, leagueLogo: leagueLogo, countryLogo: countryLogo, leagueYear: leagueYear)
                leaguesArr.append(league)
            }
        } catch {
            print("Error fetching leagues: \(error)")
        }
        return leaguesArr
    }

    // Delete a specific league
    func deleteLeague(_ league: LeagueModel) {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", league.leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                managedContext.delete(result)
            }
            saveContext()
            print("League deleted successfully.")
        } catch {
            print("Error deleting league: \(error)")
        }
    }
    func deleteLeague(leagueKey: Int) {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                managedContext.delete(result)
            }
            saveContext()
            print("League deleted successfully.")
        } catch {
            print("Error deleting league: \(error)")
        }
    }

    // Fetch a specific league by key
    func fetchLeague(byKey leagueKey: Int) -> LeagueModel? {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            if let managedLeague = results.first {
                let leagueName = managedLeague.leagueName ?? ""
                let leagueLogo = managedLeague.leagueLogo
                let leagueYear = managedLeague.leagueYear
                let countryKey = Int(managedLeague.countryKey)
                let countryName = managedLeague.countryName
                let countryLogo = managedLeague.countryLogo

                return LeagueModel(leagueKey: leagueKey, leagueName: leagueName, countryKey: countryKey, countryName: countryName, leagueLogo: leagueLogo, countryLogo: countryLogo, leagueYear: leagueYear)
            }
        } catch {
            print("Error fetching league: \(error)")
        }
        return nil
    }
}

