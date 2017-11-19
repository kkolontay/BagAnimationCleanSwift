//
//  Networking.swift
//  BagAnimations
//
//  Created by kkolontay on 11/12/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit
import GiphyCoreSDK

typealias CompletionHandler = (GPHListMediaResponse?, Error?) -> Void

class GiphyAPIManage: NSObject {
    let keyId = "vaxnHfII3hvG52U6HOot95AK0nVZipIJ";
    var client: GPHClient?
    private var maximumAnimationItem = 0
    private var offsetAnimationItem = 0
    private var limitAnimationItem = 25
    private var searchString: String!
    
    override init() {
        super.init()
        client = GPHClient(apiKey:keyId)
    }

    func search(_ search: String, completionHandler: @escaping CompletionHandler) {
        searchString = search
        maximumAnimationItem = 0
        offsetAnimationItem = 0
        limitAnimationItem = 25
        guard let client = client else {
            return
        }
        client.search(search) { (response, error) in
            if error != nil {
                completionHandler(nil, error)
                fatalError("searching error")
            }
            self.maximumAnimationItem = (response?.pagination?.count)!
            completionHandler(response, nil)
        }
    }
    
    func next(completionHandler: @escaping CompletionHandler) {
        if offsetAnimationItem + limitAnimationItem < maximumAnimationItem {
            offsetAnimationItem += limitAnimationItem
        }
        client?.search(searchString, media: .gif, offset:offsetAnimationItem, limit: limitAnimationItem, rating: .ratedR, lang: .english) {
            (response, error) in
            if error != nil {
                completionHandler(nil, error)
                fatalError("next searching wrong")
            }
            completionHandler(response, nil)
        }
            
    }
}
