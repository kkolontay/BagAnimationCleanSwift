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
    
    init(_ networkData: GPHListMediaResponse) {
        super.init()
        self.networkDataItems = networkData.data
        dataManager = DataManager()
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
            }
        }
        dataManager.save()
    }
}
