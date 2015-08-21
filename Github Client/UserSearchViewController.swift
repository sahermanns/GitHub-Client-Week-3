//
//  UserSearchViewController.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/19/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
  
  var users = [User]()
  lazy var imageQueue = NSOperationQueue()
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  let cellSize = CGSize(width: 100, height: 100)
  var desiredFinalImageSize : CGSize!
  var startingScale : CGFloat = 0
  var scale : CGFloat = 0

  

    override func viewDidLoad() {
        super.viewDidLoad()

      searchBar.delegate = self
      
    }
    override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.delegate = self
      
    }
    override func viewWillDisappear(animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.delegate = nil
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "ShowUserDetail" {
        if let destination = segue.destinationViewController as? UserDetailViewController,
          indexPath = collectionView.indexPathsForSelectedItems().first as? NSIndexPath {
            let user = users[indexPath.row]
            destination.selectedUser = user
        }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: Search bar extension
extension UserSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    
    GithubService.usersForSearchTerm(searchBar.text, userSearchCallBack: { (errorDescription, users) -> (Void) in
      if let users = users {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.users = users
          self.collectionView.reloadData()
        })
      }
    })
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    
    return text.validateForURL()
    
  }
}

//MARK: CollectionView data source functionality
extension UserSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
    var user = users[indexPath.row]
    cell.imageView.image = nil
    cell.alpha = 0
    
    cell.tag++
    let tag = cell.tag
    
    if let userImage = user.userImage {
      cell.imageView.image = userImage
    } else {
      imageQueue.addOperationWithBlock({ () -> Void in
        if let imageURL = NSURL(string: user.avatarURL),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            var size : CGSize
            switch UIScreen.mainScreen().scale {
            case 2:
              size = CGSize(width: 140, height: 140)
            case 3:
              size = CGSize(width: 210, height: 210)
            default:
              size = CGSize(width: 70, height: 70)
              
            }
            let resizedImage = ImageResizer.resizeImage(image, size: size)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              user.userImage = resizedImage
              self.users[indexPath.row] = user
              if cell.tag == tag {
                cell.imageView.image = resizedImage
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                  cell.alpha = 1
                })
              }
              
            })
        }
      })

    }
    return cell
    }
  }

//MARK: navigation controller as delegate
extension UserSearchViewController : UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    
    return toVC is UserDetailViewController ? ToUserDetailAnimationController() : nil
    
  }
}


