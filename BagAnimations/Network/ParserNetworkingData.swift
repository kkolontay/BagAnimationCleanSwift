//
//  ParserNetworkingData.swift
//  BagAnimations
//
//  Created by kkolontay on 11/18/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit
import GiphyCoreSDK

class ParserNetworkingData: NSObject {
  var networkDataItems: [GPHMedia]!
  var dataManager: DataManager!
  var listAnimations: Array<AnimationItem>?
  
  init(_ networkData: GPHListMediaResponse) {
    super.init()
    self.networkDataItems = networkData.data
    dataManager = DataManager()
    listAnimations = Array<AnimationItem>()
    parse()
  }
  func parse() {
    for item in networkDataItems {
      if dataManager.fetchAnimationItemById(id: item.id) == nil  {
        let itemCoreData = dataManager.createAnimationItem()
        itemCoreData?.id = item.id
        itemCoreData?.slug = item.slug
        itemCoreData?.smallAnimationWidth = Float((item.images?.fixedWidth?.width)!)
        itemCoreData?.smallAnimationHeight = Float((item.images?.fixedWidth?.height)!)
        itemCoreData?.bigAnimationURL = item.images?.original?.gifUrl
        itemCoreData?.smallAnimationURL = item.images?.fixedWidth?.gifUrl
        if itemCoreData != nil {
        listAnimations?.append(itemCoreData!)
        }
        dataManager.save()
      } else {
        if let animationItem = dataManager.fetchAnimationItemById(id: item.id) {
          listAnimations?.append(animationItem)
        }
      }
    }
    dataManager.save()
  }
  
  func fetchAnimationItems() -> Array<AnimationItem> {
    return listAnimations!
  }
}
