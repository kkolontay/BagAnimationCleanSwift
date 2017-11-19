//
//  AnimationCollectionViewCell.swift
//  BagAnimations
//
//  Created by kkolontay on 11/12/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageAnimation: UIImageView!
  @IBOutlet weak var activity: UIActivityIndicatorView!
  var animationItem: AnimationItem!
  func setData(_ animationItem: AnimationItem) {
    
  }
  
}
