//
//  MenuTableViewController.swift
//  
//
//  Created by Sarah Hermanns on 8/17/15.
//
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      if let token = KeychainService.loadToken() {
      } else {
          AuthService.performInitialRequest()
      }
    }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowRepositories" {
      let destinationVC = segue.destinationViewController as! RepositoryViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      
    }
  }
  
}
