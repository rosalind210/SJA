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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as! TopicTableViewCell
        let row = indexPath.row
        // Hard code topics into menu
        if row == 0 {
            cell.topicLabel.text = "Class"
        } else if row == 1 {
            cell.topicLabel.text = "Crime"
        } else if row == 2 {
            cell.topicLabel.text = "Education"
        } else if row == 3 {
            cell.topicLabel.text = "Feminism"
        } else if row == 4 {
            cell.topicLabel.text = "Mental Illness"
        } else if row == 5 {
            cell.topicLabel.text = "Race"
        } else if row == 6 {
            cell.topicLabel.text = "Self Worth"
        } else if row == 7 {
            cell.topicLabel.text = "Sexism"
        } else if row == 8 {
            cell.topicLabel.text = "Spectrum"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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