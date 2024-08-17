//
//  LocalServices.swift
//  SportsAppITI
//
//  Created by Mahmoud  on 17/08/2024.
//

import Foundation
import CoreData
import UIKit


class LocalServices {
    static func storeLeague(_ league: LeagueModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        // Check if the news item already exists
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d",league.leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.isEmpty {
                // If not found, insert a new news item
                guard let newsEntity = NSEntityDescription.entity(forEntityName: "FavLeagues", in: managedContext) else { return }
                let newsObject = NSManagedObject(entity: newsEntity, insertInto: managedContext)
                newsObject.setValue(league.leagueKey, forKey: "leagueKey")
                newsObject.setValue(league.leagueName, forKey: "leagueName")
                newsObject.setValue(league.leagueLogo, forKey: "leagueLogo")
                newsObject.setValue(league.leagueYear, forKey: "leagueYear")
                newsObject.setValue(league.countryKey, forKey: "countryKey")
                newsObject.setValue(league.countryName, forKey: "countryName")
                newsObject.setValue(league.countryLogo, forKey: "countryLogo")
                
                do {
                    try managedContext.save()
                    print("News item saved successfully.")
                } catch {
                    print("Error saving news item: \(error)")
                }
            } else {
                print("News item already exists.")
            }
        } catch {
            print("Error fetching news items: \(error)")
        }
    }
    
    static func getLeagues() -> [LeagueModel] {
        var leaguesArr = [LeagueModel]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeagues")
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for managedLeague in results {
                let leagueKey = managedLeague.value(forKey: "leagueKey") as! Int
                let leagueName = managedLeague.value(forKey: "leagueName") as! String
                let leagueLogo = managedLeague.value(forKey: "leagueLogo") as! String?
                let leagueYear = managedLeague.value(forKey: "leagueYear") as! String?
                let countryKey = managedLeague.value(forKey: "countryKey") as! Int?
                let countryName = managedLeague.value(forKey: "countryName") as! String?
                let countryLogo = managedLeague.value(forKey: "countryLogo") as! String?
                
                let league = LeagueModel(leagueKey: leagueKey, leagueName: leagueName, countryKey: countryKey, countryName: countryName, leagueLogo: leagueLogo, countryLogo: countryLogo, leagueYear: leagueYear)
                leaguesArr.append(league)
            }
            
        } catch {
            print("Error fetching news: \(error)")
        }
        return leaguesArr
    }
    
    static func deleteleague(_  league: LeagueModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", league.leagueKey)

        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                context.delete(result)
            }
            try context.save()
            print("News item deleted successfully.")
        } catch {
            print("Error deleting news item: \(error)")
        }
    }
}
