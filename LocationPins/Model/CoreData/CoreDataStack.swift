//
//  CoreDataStack.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CoreDataStack: NSObject {
  static let shared = CoreDataStack()
  
  private override init() { }
  
  //Returns the current Persistent Container for CoreData
  class func getContext() -> NSManagedObjectContext {
    return CoreDataStack.shared.persistentContainer.viewContext
  }
  
  // MARK: - Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "LocationPins")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        print("Unable to load presistentContainer")
      }
    })
    return container
  }()
  
  //MARK: - GET / Fetch / Requests / Save
  class func getAllLocations() -> Array<Location> {
    let all = NSFetchRequest<Location>(entityName: "Location")
    var allLocations = [Location]()
    do {
      let fetched = try CoreDataStack.getContext().fetch(all)
      allLocations = fetched
    } catch {
      let nserror = error as NSError
      print(nserror.description)
    }
    return allLocations
  }
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
        print("Data Saved to Context")
      } catch {
        let nserror = error as NSError
        print("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  class func isLocationExist(id: Int) -> Bool {
    let managedContext = CoreDataStack.getContext()
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
    fetchRequest.fetchLimit =  1
    fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
    do {
      let count = try managedContext.count(for: fetchRequest)
      if count > 0 {
        return true
      }else {
        return false
      }
    }catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return false
    }
  }
  
  // REMOVE / Delete
  class func deleteLocation(with id: String) -> Bool {
    let success: Bool = true
    let requested = NSFetchRequest<Location>(entityName: "Location")
    requested.predicate = NSPredicate(format: "id == %@", id)

    do {
      let fetched = try CoreDataStack.getContext().fetch(requested)
      for location in fetched {
        CoreDataStack.getContext().delete(location)
      }
      return success
    } catch {
      let nserror = error as NSError
      print(nserror.description)
    }
    return !success
  }
  
  class func deleteAllLocations() {
    do {
      let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
      let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)
      try CoreDataStack.getContext().execute(deleteALL)
      CoreDataStack.shared.saveContext()
    } catch {
      print ("There is an error in deleting records")
    }
  }
  
}


