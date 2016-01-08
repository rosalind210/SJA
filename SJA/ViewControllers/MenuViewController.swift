//
//  MenuViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewName: String?
    var topics: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topics = ["Class", "Crime", "Education", "Feminism","Race",  "Sexism", "Spectrum", "Wellness"]
        
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let _ = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: false)
        }
    }
    
    // Passes the topic, and therefore the rss links, through the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! TopicViewController
        let indexPath = tableView.indexPathForSelectedRow
        let topic = topics[indexPath!.row]
        destinationVC.currentTopic = topic
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let _ = indexPath.row

        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as! TopicTableViewCell
        let row = indexPath.row
        cell.topicLabel.text = topics[row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
 
}