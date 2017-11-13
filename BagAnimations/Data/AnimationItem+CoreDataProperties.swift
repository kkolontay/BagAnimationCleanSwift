//
//  AnimationItem+CoreDataProperties.swift
//  BagAnimations
//
//  Created by kkolontay on 11/13/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//
//

import Foundation
import CoreData


extension AnimationItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimationItem> {
        return NSFetchRequest<AnimationItem>(entityName: "AnimationItem")
    }

    @NSManaged public var bigAnimagionData: NSData?
    @NSManaged public var bigAnimationURL: String?
    @NSManaged public var id: String?
    @NSManaged public var slug: String?
    @NSManaged public var smallAnimationData: NSData?
    @NSManaged public var smallAnimationHeight: Float
    @NSManaged public var smallAnimationURL: String?
    @NSManaged public var smallAnimationWidth: Float

}
