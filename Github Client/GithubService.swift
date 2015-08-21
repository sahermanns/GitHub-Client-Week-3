//
//  GithubService.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/17/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import Foundation

class GithubService {
  
  class func repositoriesForSearchTerm(searchTerm: String, repoSearchCallBack: (errorDescription: String?, repositories :[Repository]?) -> (Void)) {

    let baseURL = "https://api.github.com/search/repositories"
    let finalURL = baseURL + "?q=\(searchTerm)"
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
      if let token = KeychainService.loadToken() {
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
      }
    
    if let url = NSURL(string:finalURL) {
            
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, responce, error) -> Void in
        if let error = error {
          repoSearchCallBack(errorDescription: "error", repositories: nil)
        } else if let httpResponse = responce as? NSHTTPURLResponse {
          println("error")
          switch httpResponse.statusCode {
          case 200...299:
            println(httpResponse.statusCode)
          let repositories = GithubJSONParser.repositoriesFromJSONData(data)
            repoSearchCallBack(errorDescription: nil, repositories:repositories)
          case 400...499:
            repoSearchCallBack(errorDescription:"There was an error on the server side", repositories: nil)
          case 500...599:
           repoSearchCallBack(errorDescription:"There was an error on the server side, try again later", repositories: nil)
          default:
            repoSearchCallBack(errorDescription:"There was an unknown error", repositories: nil)
          }
          repoSearchCallBack(errorDescription: nil, repositories: nil)
        }
      }).resume()
      
    }
  }
  
  class func usersForSearchTerm(searchTerm: String, userSearchCallBack: (errorDescription: String?, users :[User]?) -> (Void)) {
    
    let baseURL = "https://api.github.com/search/users"
    let finalURL = baseURL + "?q=\(searchTerm)"
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    if let token = KeychainService.loadToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    if let url = NSURL(string:finalURL) {
      
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, responce, error) -> Void in
        if let error = error {
          userSearchCallBack(errorDescription: "error", users: nil)
        } else if let httpResponse = responce as? NSHTTPURLResponse {
          println("error")
          switch httpResponse.statusCode {
          case 200...299:
            println(httpResponse.statusCode)
            let users = GithubJSONParser.usersFromJSONData(data)
            userSearchCallBack(errorDescription: nil, users: users)
          case 400...499:
            userSearchCallBack(errorDescription:"There was an error on the server side", users: nil)
          case 500...599:
            userSearchCallBack(errorDescription:"There was an error on the server side, try again later", users: nil)
          default:
            userSearchCallBack(errorDescription:"There was an unknown error",users: nil)
          }
          userSearchCallBack(errorDescription: nil, users: nil)
        }
      }).resume()
    }
  }
  
}
