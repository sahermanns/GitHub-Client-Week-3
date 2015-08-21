//
//  ToUserDetailAnimationController.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/21/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject {
  override init() {
    
  }
}

//MARK: Animation features for transition to user detail VC
extension ToUserDetailAnimationController: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserSearchViewController,
      toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserDetailViewController {
    
      let containerView = transitionContext.containerView()
      toVC.view.alpha = 0
      containerView.addSubview(toVC.view)
      
      let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      let userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as! UserCell
      
      let snapShot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
      
      snapShot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
        
      containerView.addSubview(snapShot)
      userCell.hidden = true
      toVC.view.layoutIfNeeded()
      toVC.imageView.hidden = true
      let destinationFrame = toVC.imageView.frame
      
      UIView.animateWithDuration(0.4, animations: { () -> Void in
        snapShot.frame = destinationFrame
        toVC.view.alpha = 1}, completion: { (finished) -> Void in
          userCell.hidden = false
          toVC.imageView.hidden = false
          snapShot.removeFromSuperview()
          if finished {
            transitionContext.completeTransition(finished)
          } else {
            transitionContext.completeTransition(finished)
          }
      })
    
    }
  }

}