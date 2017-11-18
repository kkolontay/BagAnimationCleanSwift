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
    
    //    func fetchAnimationItemById( id: String, completionHandler: @escaping (AnimationItem?, String?) -> Void) {
    //        privateManagedObjectContext?.perform {
    //            do {
    //                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimationItem")
    //                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    //                let results = try self.privateManagedObjectContext?.fetch(fetchRequest) as! [AnimationItem]
    //                if results.count == 0 {
    //                    completionHandler(nil, "Can't found any results.")
    //                    return
    //                }
    //                completionHandler(results.first, nil)
    //            } catch {
    //                completionHandler(nil, "Something went wrong." )
    //            }
    //        }
    //    }
    
    func fetchAnimationItemById( id: String) -> AnimationItem? {
        var result: [AnimationItem]?
        privateManagedObjectContext?.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimationItem")
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                result = try self.privateManagedObjectContext?.fetch(fetchRequest) as? [AnimationItem]
            } catch {
                fatalError( "Something went wrong." )
            }
        }
        if result != nil {
            return result?.first
        }
        return nil
    }
    
    func fetchAnimationItemBySearching( searchString: String, completionHandler: @escaping([AnimationItem]?, String?) -> Void) {
        privateManagedObjectContext?.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimationItem")
                fetchRequest.predicate = NSPredicate(format: "slug contains[c] %@", searchString)
                let results = try self.privateManagedObjectContext?.fetch(fetchRequest) as! [AnimationItem]
                if results.count == 0 {
                    completionHandler(nil, "Nothing found")
                    return
                }
                completionHandler(results, nil)
            }catch {
                completionHandler(nil, "SomeThing went wrong.")
            }
        }
    }
    
    //    func createAnimationItem(_ completionHandler: @escaping(AnimationItem?, String?) -> Void) {
    //        privateManagedObjectContext?.perform {
    //            if   let managedOrder = NSEntityDescription.insertNewObject(forEntityName: "AnimationItem", into: self.privateManagedObjectContext!) as? AnimationItem {
    //                completionHandler(managedOrder, nil)
    //            }
    //        }
    //    }
    
    func createAnimationItem() -> AnimationItem? {
        var animationItem: AnimationItem?
        privateManagedObjectContext?.perform {
            animationItem = NSEntityDescription.insertNewObject(forEntityName: "AnimationItem", into: self.privateManagedObjectContext!) as? AnimationItem
        }
        if animationItem != nil {
            return animationItem
        }
        return nil
    }
    
    func save() {
        do {
            try self.privateManagedObjectContext?.save()
        } catch {
            fatalError("Error saving data")
        }
    }
    
    func deleteAllItems() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"AnimationItem")
            if  let results = try self.privateManagedObjectContext?.fetch(fetchRequest) as? [AnimationItem] {
                for item: AnimationItem in results {
                    self.privateManagedObjectContext?.delete(item)
                }
                save()
            }
        } catch {
            fatalError("can't remove any Atiems")
        }
    }
}
