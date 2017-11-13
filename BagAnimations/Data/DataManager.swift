//
//  DataManager.swift
//  BagAnimations
//
//  Created by kkolontay on 11/13/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
  var mainManagedObjectContext: NSManagedObjectContext?
  var privateManagedObjectContext: NSManagedObjectContext?
  
  override init() {
    super.init()
    
    guard  let modelURL = Bundle.main.url(forResource: "BagAnimations", withExtension: "momd") else {
      fatalError("Error loading model from bundle")
    }
    
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Error initializing mom from:\(modelURL)")
    }
    
    let persistenStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
    mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    mainManagedObjectContext?.persistentStoreCoordinator = persistenStoreCoordinator
    
    privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateManagedObjectContext?.parent = mainManagedObjectContext
  }
  
  deinit {
    do {
      try self.mainManagedObjectContext?.save()
    } catch {
      fatalError("Saving data Error")
    }
  }
  func fetchAnimationItems(completionHandler: @escaping ([AnimationItem]?, String?) -> Void) {
    privateManagedObjectContext?.perform {
      do {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimationItem")
        let result = try self.privateManagedObjectContext?.fetch(fetchRequest) as! [AnimationItem]
        completionHandler(result, nil)
      } catch {
        completionHandler(nil, "Fetching Item Error")
      }
    }
  }
}
