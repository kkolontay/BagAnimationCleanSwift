//
//  FetchImage.swift
//  BagAnimations
//
//  Created by kkolontay on 11/18/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

typealias HanlerResponse = (Data?, String?) -> Void

class FetchImage: NSObject {
    var url: String?
    
    init(_ url: String) {
        super.init()
        self.url = url
    }
    
    func fetchImage(_ handlerResponse: @escaping HanlerResponse) {
        if let urlString = url, let urlRequest = URL(string: urlString) {
            URLSession.shared.dataTask(with: urlRequest) {
                data, response, error in
                if (response as! HTTPURLResponse).statusCode != 200 {
                    handlerResponse(nil, String(format: "HttpErrro %d", (response as! HTTPURLResponse).statusCode))
                    return
                }
                if error != nil {
                    handlerResponse(nil, error?.localizedDescription)
                    return
                }
                handlerResponse(data, nil)
            }.resume()
        }
    }
}
