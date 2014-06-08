//
//  PRPStatus.swift
//  ParauParau
//
//  Created by teriiehina on 08/06/2014.
//  Copyright (c) 2014 teriiehina. All rights reserved.
//

import UIKit

class PRPStatus: NSObject
{
  var text: NSString
  var avatarURL: NSURL
  var avatarName: NSString
  var date: NSDate
  
  init(status: AnyObject)
  {
    self.text = status.objectForKey("text") as NSString

    let user  = status.objectForKey("user") as NSDictionary
    var url   = user["profile_image_url"]   as NSString
    url       = url.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger")
    
    self.avatarURL  = NSURL(string: url)
    self.avatarName = user["name"] as NSString
    
    var createdAt  = status.objectForKey("created_at") as NSString
    
    var dateFormatter = NSDateFormatter();
    dateFormatter.dateFormat = "EEE MMM d HH:MM:SS Z YYYY"
    
    if let parsedDate = dateFormatter.dateFromString(createdAt)
    {
      self.date = parsedDate
    }
    else
    {
      self.date = NSDate()
    }
    
    super.init()
  }
}
