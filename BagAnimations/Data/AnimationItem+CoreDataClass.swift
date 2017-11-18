//
//  AnimationItem+CoreDataClass.swift
//  BagAnimations
//
//  Created by kkolontay on 11/13/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AnimationItem)
public class AnimationItem: NSManagedObject {
    
    static func ==(lhs: AnimationItem, rhs: AnimationItem) -> Bool {
        return lhs.id == rhs.id
    }
    
}
