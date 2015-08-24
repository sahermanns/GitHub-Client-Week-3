//
//  WebViewController.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/21/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      let webView = WKWebView(frame: view.frame)
      
      let urlRequest = NSURLRequest(URL: NSURL(string: "https://api.github.com/search/repositories")!)
      webView.loadRequest(urlRequest)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
