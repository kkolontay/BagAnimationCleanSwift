//
//  ListAnimationInteractor.swift
//  BagAnimations
//
//  Created by kkolontay on 10/30/17.
//  Copyright (c) 2017 kkolontay.com. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListAnimationBusinessLogic
{
  //func doSomething(request: ListAnimation.Something.Request)
  func fetchAnimation(request: ListAnimation.FetchAnimationItems.Request)
}

protocol ListAnimationDataStore
{
  //var name: String { get set }
}

class ListAnimationInteractor: ListAnimationBusinessLogic, ListAnimationDataStore
{
  var presenter: ListAnimationPresentationLogic?
  var worker: GiphyAPIManage?
  var parser: ParserNetworkingData?
  //var name: String = ""
  
  // MARK: Do something
  func fetchAnimation(request: ListAnimation.FetchAnimationItems.Request) {
    if request.searchingSubject == nil {
      let response = ListAnimation.FetchAnimationItems.Response(animationItems: nil, error: "Nothing found")
      presenter?.presentAnimation(response: response)
    } else {
      worker = GiphyAPIManage()
      worker?.client?.search(request.searchingSubject!) {
        response, error in
        if error != nil {
          let response = ListAnimation.FetchAnimationItems.Response(animationItems: nil, error: error?.localizedDescription)
          self.presenter?.presentAnimation(response: response)
          return
        }
        if response != nil {
          self.parser = ParserNetworkingData(response!)
          let response = ListAnimation.FetchAnimationItems.Response(animationItems: self.parser?.fetchAnimationItems(), error: nil)
          self.presenter?.presentAnimation(response: response)
        }
      }
    }
    
  }
//  func doSomething(request: ListAnimation.Something.Request)
//  {
//    worker = ListAnimationWorker()
//    worker?.doSomeWork()
//    
//    let response = ListAnimation.Something.Response()
//    presenter?.presentSomething(response: response)
//  }
}
