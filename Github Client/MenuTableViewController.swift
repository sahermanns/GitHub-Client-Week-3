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

}