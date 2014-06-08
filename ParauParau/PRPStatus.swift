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
  var text: NSString!
  
  init(status: AnyObject)
  {
    self.text = status.objectForKey("text") as NSString!
    super.init()
  }
}
