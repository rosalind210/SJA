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
    var Topics: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Topics = ["Class", "Crime", "Education", "Feminism","Race",  "Sexism", "Spectrum", "Wellness"]
        
        tableView.dataSource = self
        //tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let table = tableView.indexPathForSelectedRow() {
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! TopicViewController
        let indexPath = tableView.indexPathForSelectedRow()
        let topic = Topics[indexPath!.row]
        destinationVC.currentTopic = topic
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
//        // holds topic chosen info
//        let selectedTopic = Topics[row]
//        
//        //println(selectedTopic)
//        
//        // sets the destination view controller to the topic view controller
//        let destinationVC = TopicViewController()
//        destinationVC.currentTopic = selectedTopic // sets the topic chosen to a variable in tvc
//        //perform segue
//        destinationVC.performSegueWithIdentifier("MenuClick", sender: self)
        
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if viewName == "View Controller"{
            viewName = "Topic"
            var source = self.parentViewController as! ViewController
            source.menuContainer.hidden = true
            viewName = "Topic"
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as! TopicTableViewCell
        let row = indexPath.row
        cell.topicLabel.text = Topics[row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Topics.count
    }
    
 
}