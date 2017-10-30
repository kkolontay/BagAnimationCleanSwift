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
  func doSomething(request: ListAnimation.Something.Request)
}

protocol ListAnimationDataStore
{
  //var name: String { get set }
}

class ListAnimationInteractor: ListAnimationBusinessLogic, ListAnimationDataStore
{
  var presenter: ListAnimationPresentationLogic?
  var worker: ListAnimationWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: ListAnimation.Something.Request)
  {
    worker = ListAnimationWorker()
    worker?.doSomeWork()
    
    let response = ListAnimation.Something.Response()
    presenter?.presentSomething(response: response)
  }
}