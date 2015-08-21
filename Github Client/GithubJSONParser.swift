//
//  GithubJSONParser.swift
//  Github Client
//
//  Created by Sarah Hermanns on 8/18/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import Foundation

class GithubJSONParser {
  class func repositoriesFromJSONData(jsonData: NSData) -> [Repository]? {
    
    var error : NSError?
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String:AnyObject]{
      var repositories = [Repository]()
      if let items = rootObject["items"] as? [[String: AnyObject]] {
        for repositoryObject in items {
          if let name = repositoryObject["name"] as? String,
            htmlURL = repositoryObject["html_url"] as? String,
            owner = repositoryObject["owner"] as? [String: AnyObject],
            login = owner["login"] as? String,
            avatarURL = owner["avatar_url"] as? String {
            
              let repository = Repository(name: name, htmlURL: htmlURL, login: login)
              
              repositories.append(repository)
          } else {
            //          could not enter parsing loop
          }
        }
      }

      return repositories
    }
    if let error = error {
      
    }
    return nil
  }
  
  class func usersFromJSONData(jsonData: NSData) -> [User]? {
    
    var error : NSError?
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String:AnyObject]{
      var users = [User]()
      if let items = rootObject["items"] as? [[String: AnyObject]] {
        for repositoryObject in items {
          if let login = repositoryObject["login"] as? String,
            avatarURL = repositoryObject["avatar_url"] as? String {
              
              let user = User(login: login, avatarURL: avatarURL, userImage: nil)
              
              users.append(user)
          } else {
            //          could not enter parsing loop
          }
        }
      }
      
      return users
    }
    if let error = error {
      
    }
    return nil
  }
  
}
