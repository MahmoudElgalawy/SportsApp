import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func storeLeague(_ league: LeagueModel)
    func deleteLeague(_ league: LeagueModel)
    func fetchLeague(byKey key: Int) -> LeagueModel?
}

// MARK: - CoreDataManager
class CoreDataManager:CoreDataManagerProtocol{
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }

    init(persistentContainer: NSPersistentContainer) {
        self.managedContext = persistentContainer.viewContext
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

    func storeLeague(_ league: LeagueModel) {
        if !doesLeagueExist(leagueKey: league.leagueKey) {
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
    }

    func fetchLeagues() -> [LeagueModel] {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        var leaguesArr = [LeagueModel]()

        do {
            let results = try managedContext.fetch(fetchRequest)
            leaguesArr = results.map { managedLeague in
                return LeagueModel(
                    leagueKey: Int(managedLeague.leagueKey),
                    leagueName: managedLeague.leagueName ?? "",
                    countryKey: Int(managedLeague.countryKey),
                    countryName: managedLeague.countryName,
                    leagueLogo: managedLeague.leagueLogo,
                    countryLogo: managedLeague.countryLogo,
                    leagueYear: managedLeague.leagueYear
                )
            }
        } catch {
            print("Error fetching leagues: \(error)")
        }
        return leaguesArr
    }

    func deleteLeague(_ league: LeagueModel) {
        deleteLeague(byKey: league.leagueKey)
    }

    func deleteLeague(byKey leagueKey: Int) {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)

        do {
            let results = try managedContext.fetch(fetchRequest)
            results.forEach { managedContext.delete($0) }
            saveContext()
            print("League deleted successfully.")
        } catch {
            print("Error deleting league: \(error)")
        }
    }

    func fetchLeague(byKey leagueKey: Int) -> LeagueModel? {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)

        do {
            if let managedLeague = try managedContext.fetch(fetchRequest).first {
                return LeagueModel(
                    leagueKey: leagueKey,
                    leagueName: managedLeague.leagueName ?? "",
                    countryKey: Int(managedLeague.countryKey),
                    countryName: managedLeague.countryName,
                    leagueLogo: managedLeague.leagueLogo,
                    countryLogo: managedLeague.countryLogo,
                    leagueYear: managedLeague.leagueYear
                )
            }
        } catch {
            print("Error fetching league: \(error)")
        }
        return nil
    }

    private func doesLeagueExist(leagueKey: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)

        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if league exists: \(error)")
            return false
        }
    }
}
