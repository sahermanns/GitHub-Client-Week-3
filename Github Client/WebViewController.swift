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
      
      let urlRequest = NSURLRequest(URL: NSURL(string: "http://google.com")!)
      webView.loadRequest(urlRequest)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
