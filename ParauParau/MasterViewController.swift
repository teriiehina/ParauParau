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
    var tweets: AnyObject[]!
    
    init(coder aDecoder: NSCoder!)
    {

        self.twitterApi = STTwitterAPI.twitterAPIOSWithFirstAccount()
        
        super.init(coder: aDecoder);
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        if objects == nil {
            objects = NSMutableArray()
        }
        objects.insertObject(NSDate.date(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // #pragma mark - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = objects[indexPath.row] as NSDate
            (segue.destinationViewController as DetailViewController).detailItem = object
        }
    }

    // #pragma mark - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.tweets
        {
            return self.tweets.count
        }
        else
        {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object : AnyObject  = self.tweets[indexPath.row] as AnyObject
        var text : String!      = object.valueForKey("text") as String!
        
        cell.textLabel.text = text
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


    // #pragma mark - Twitter
    
    func fetchTweets()
    {
        
        let handleSuccess = {(tweets: AnyObject[]!) -> Void in
            
            self.tweets = tweets
            println("cool")
            self.tableView.reloadData()
        }
        
        let handleError = {(error: NSError!) -> Void in
            
            println(error)
        }
        
        self.twitterApi.getHomeTimelineSinceID(nil, count: 100, successBlock: handleSuccess, errorBlock: handleError)
        
    }
}

