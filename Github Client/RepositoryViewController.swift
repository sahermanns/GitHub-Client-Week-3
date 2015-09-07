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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if let webViewController = segue.destinationViewController as? WebViewController, indexPath = repositoryTableView.indexPathForSelectedRow() {
      let repository = repositories[indexPath.row]
      webViewController.passedURL = repository.htmlURL
    }
  }

}
//MARK: Search bar extension
extension RepositoryViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {

    
    GithubService.repositoriesForSearchTerm(searchBar.text, repoSearchCallBack: { (errorDescription, repositories) -> (Void) in
      if let repositories = repositories {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.repositories = repositories
          self.repositoryTableView.reloadData()
        })
      }
    })
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    
    return text.validateForURL()
    
  }
}


//MARK: table view extensions
extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowWebView", sender: nil)
  }

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath) as! RepositoryCell
    var repository = repositories[indexPath.row]
    cell.loginName.text = repository.login
    cell.repositoryName.text = repository.name
    cell.repositoryURL.text = repository.htmlURL
    return cell
  }

}