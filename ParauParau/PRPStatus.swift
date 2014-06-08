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
  
  init(status: AnyObject)
  {
    self.text = status.objectForKey("text") as NSString

    let user  = status.objectForKey("user") as NSDictionary
    let url   = user["profile_image_url"]   as NSString
    
    self.avatarURL  = NSURL(string: url)
    
    super.init()
  }
}
