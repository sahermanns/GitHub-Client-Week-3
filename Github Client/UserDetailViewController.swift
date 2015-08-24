//
//  UserDetailViewController.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/21/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
  
  
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  var selectedUser: User!
  
    override func viewDidLoad() {
        super.viewDidLoad()
//      navigationController?.delegate = nil
      imageView.image = selectedUser.userImage
      
      userName.text = selectedUser.login
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
