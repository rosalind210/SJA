//
//  TopicViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.dataSource = self
        menuContainer.hidden = true
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func menuAction() {
        if menuContainer!.hidden {
            menuContainer!.hidden = false
        } else {
            menuContainer!.hidden = true
        }
    }

    
}

extension TopicViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleNameCell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        let row = indexPath.row
        cell.articleName.text = "8 Churches Burned"
        cell.articleSource.text = "Feminista"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
