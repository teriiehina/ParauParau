//
//  MasterViewController.swift
//  ParauParau
//
//  Created by teriiehina on 08/06/2014.
//  Copyright (c) 2014 teriiehina. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  
  var objects = NSMutableArray()
  var twitterApi: STTwitterAPI!
  var tweets = PRPStatus[]()
  
  var labelToComputeCellHeight: UILabel
  
  init(coder aDecoder: NSCoder!)
  {
    self.labelToComputeCellHeight       = UILabel()
    self.labelToComputeCellHeight.font  = UIFont.systemFontOfSize(13)
    
    self.labelToComputeCellHeight.numberOfLines = 0
    self.labelToComputeCellHeight.lineBreakMode = .ByTruncatingTail
    
    self.twitterApi = STTwitterAPI.twitterAPIOSWithFirstAccount()
    super.init(coder: aDecoder);
  }
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "postNewTweet:")
    self.navigationItem.rightBarButtonItem = addButton
  }
  
  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)
    
    let handleSuccess = {(username: String!) -> Void in
      
      println("youpi")
      self.fetchTweets()
    }
    
    let handleError = {(error: NSError!) -> Void in
      
      println(error)
    }
    
    self.twitterApi.verifyCredentialsWithSuccessBlock(handleSuccess, errorBlock: handleError)
    
  }
  
  // #pragma mark - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if segue.identifier == "showDetail"
    {
      let indexPath = self.tableView.indexPathForSelectedRow()
      let object = objects[indexPath.row] as NSDate
      
      (segue.destinationViewController as DetailViewController).detailItem = object
    }
  }
  
  // #pragma mark - Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return self.tweets.count
  }
  
  override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
  {
    var tweet   = self.tweets[indexPath.row] as PRPStatus
    let minHeight = 80 as CGFloat
    
    self.labelToComputeCellHeight.text  = tweet.text
    var computedHeight = self.labelToComputeCellHeight.sizeThatFits(CGSize(width: 384, height: 1000)).height + 33
    
    return computedHeight > minHeight ? computedHeight : minHeight
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("StatusCell", forIndexPath: indexPath) as PRPStatusTableViewCell
    
    cell.status = self.tweets[indexPath.row]
    
    return cell
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
  {
    return false
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
  {
    if editingStyle == .Delete
    {
      objects.removeObjectAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    else if editingStyle == .Insert
    {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
  
  override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
  {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // #pragma mark - Twitter
  
  func fetchTweets()
  {
    let handleSuccess = {(tweets: AnyObject[]!) -> Void in
      
      println (tweets[0])
      for tweet : AnyObject in tweets
      {
        let status = PRPStatus(status: tweet)
        self.tweets.append(status)
      }

      self.tableView.reloadData()
    }
    
    let handleError = {(error: NSError!) -> Void in
      println(error)
    }
    
    self.twitterApi.getHomeTimelineSinceID(nil, count: 100, successBlock: handleSuccess, errorBlock: handleError)
  }
  
  func postNewTweet(sender: UIControl)
  {
    println("Coming soon")
  }
  
}

