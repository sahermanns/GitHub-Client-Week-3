//
//  LoginViewController.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/19/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "newToken", name: kTokenNotification, object: nil)

    }
  
    override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      if let token = KeychainService.loadToken() {
        
        
        
      } else {
        AuthService.performInitialRequest()
      }
    }
  
    func newToken() {
      performSegueWithIdentifier("showMainMenu", sender: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func loginButtonPressed(sender: AnyObject) {
    
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: kTokenNotification, object: nil)
  }

}
