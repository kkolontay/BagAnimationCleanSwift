//
//  AnimationCollectionViewLayout.swift
//  BagAnimations
//
//  Created by kkolontay on 11/12/17.
//  Copyright © 2017 kkolontay.com. All rights reserved.
//

import UIKit

protocol AnimationLayoutDelegate: class {
  func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

class AnimationCollectionViewLayout: UICollectionViewLayout {
  weak var delegate: AnimationLayoutDelegate!
  
 lazy var numberOfCollums: Int = {
    if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
      return 3
    }
    return 2
  }()
  
  var cellPadding: CGFloat = 2
  var cache = [UICollectionViewLayoutAttributes]()
  var contentHeight: CGFloat = 0
  
  var contentWidth: CGFloat {
    guard  let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width / CGFloat (numberOfCollums) - insets.left - insets.right
  }
  
 override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    guard cache.isEmpty == true, let collectionView = collectionView else {
      return
    }
    let columnWidth = contentWidth / CGFloat(numberOfCollums)
    var xOffset = [CGFloat]()
    for column in 0 ..< numberOfCollums {
      xOffset.append(CGFloat(column ) * columnWidth)
    }
    var column = 0
    var yOffset = [CGFloat](repeating: 0, count: numberOfCollums)
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let imageHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
      let height = cellPadding * 2 + imageHeight
      let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] = yOffset[column] + height
      column = column < (numberOfCollums - 1) ? (column + 1): 0
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
}


