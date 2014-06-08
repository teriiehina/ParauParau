//
//  PRPStatusTableViewCell.swift
//  ParauParau
//
//  Created by teriiehina on 08/06/2014.
//  Copyright (c) 2014 teriiehina. All rights reserved.
//

import UIKit

class PRPStatusTableViewCell: UITableViewCell {
  
  @IBOutlet var statusLabel: UILabel
  @IBOutlet var avatarImage: UIImageView
  
  init(style: UITableViewCellStyle, reuseIdentifier: String)
  {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    // Initialization code
  }
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool)
  {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
