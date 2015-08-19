//
//  GithubService.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/17/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import Foundation

class GithubService {
  
//  static let sharedService = GithubService()
//  
//  var account: ACAccount?
//  
//  private init() {}
  
  class func repositoriesForSearchTerm(searchTerm:(String?, [Repository]?) -> (Void)) {
    
//    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL (string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
//    request.account = self.sharedService.account
//    

//   NSURLSession.account = self.sharedService.account
    
    
    let baseURL = "http://localhost:3000"
    let finalURL = baseURL + "?q=\(searchTerm)"
    if let url = NSURL(string:finalURL) {
            
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, responce, error) -> Void in
        if let error = error {
          searchTerm("could not connect to the server", nil)
        } else if let httpResponse = responce as? NSHTTPURLResponse {
          println("error")
          switch httpResponse.statusCode {
          case 200...299:
            println(httpResponse.statusCode)
          let repositories = GithubJSONParser.repositoriesFromJSONData(data)
            searchTerm(nil, repositories)
          case 400...499:
            searchTerm("There was an error on the server side", nil)
          case 500...599:
           searchTerm("There was an error on the server side, try again later", nil)
          default:
            searchTerm("There was an unknown error", nil)
          }
        }
      }).resume()
    }
  }
  
}
