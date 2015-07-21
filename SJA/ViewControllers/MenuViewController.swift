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
        
        Topics = ["Class", "Crime", "Education", "Fenimism","Race",  "Sexism", "Spectrum", "Wellness"]
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        var selectedTopic = Topics[row]
        
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

extension MenuViewController: UITableViewDelegate {
    
//    //let source = ViewController()
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let source = ViewController()
//        source.menuContainer.hidden = true
//    }
}