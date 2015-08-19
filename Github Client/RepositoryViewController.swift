//
//  RepositoryViewController.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/17/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
  
  var repositories = [Repository]()
  lazy var imageQueue = NSOperationQueue()
  
  
  @IBOutlet weak var repositoryTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

      
      repositoryTableView.registerNib(UINib(nibName: "Repository", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "RepositoryCell")
      
      
      searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
//MARK: Search bar extension
extension RepositoryViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
//    AuthService.performInitialRequest{(errorDescription, account) -> (Void) in
//      if let errorDescription = errorDescription {
//        
//      }
//      if let account = account {
//        GithubService.repositoriesForSearchTerm { (errorDescription, repositories) -> (Void) in
//          if let repositories = repositories {
//            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//              self.repositories = repositories
//              self.repositoryTableView.reloadData()
//            })
//          }
//        }
//      }
//
//        
//      }
//      
//    }
    
    GithubService.repositoriesForSearchTerm { (errorDescription, repositories) -> (Void) in
      if let repositories = repositories {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.repositories = repositories
          self.repositoryTableView.reloadData()
        })
      }
    }
  }
  
}


//MARK: table view extensions
extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate {

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath) as! RepositoryCell
    var repository = repositories[indexPath.row]
    cell.avatarImage.image = nil
    cell.loginName.text = repository.login
    cell.repositoryName.text = repository.name
    cell.repositoryURL.text = repository.htmlURL
    return cell
  }

}