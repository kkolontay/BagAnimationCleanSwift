//
//  AnimationInteractor.swift
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

protocol AnimationBusinessLogic
{
  func doSomething(request: Animation.Something.Request)
}

protocol AnimationDataStore
{
  //var name: String { get set }
}

class AnimationInteractor: AnimationBusinessLogic, AnimationDataStore
{
  var presenter: AnimationPresentationLogic?
  var worker: AnimationWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Animation.Something.Request)
  {
    worker = AnimationWorker()
    worker?.doSomeWork()
    
    let response = Animation.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
