//
//  ArticleListViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/27/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet weak var articleListTableView: UITableView!
    
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var chosenWebsite: String?
    var websiteDict: NSDictionary?
    var feedArray: [String] = []
    
    var feedCollector: FeedCollector?
    var item: MWFeedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = chosenWebsite
        
        // Take out range of topic view controllers in between current and main
        if let navigationController = navigationController {
            var navControllers = navigationController.viewControllers
            if navControllers.count > 2 {
                navControllers.removeRange(1..<(navControllers.count - 1))
                navigationController.viewControllers = navControllers
            }
        }
        
        //read through sources dictionary from supporting files
        if let dict = websiteDict {
            feedArray = websiteDict![chosenWebsite!] as! [String]
            feedCollector = FeedCollector(listOfURLs: feedArray)
        }
        
        articleListTableView.dataSource = self
        articleListTableView.delegate = self
        menuContainer.hidden = true
        
        feedCollector?.createFeedHelpers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuAction() {
        if menuContainer!.hidden {
            menuContainer!.hidden = false
        } else {
            menuContainer!.hidden = true
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ArticleClick" {
            let destVC = segue.destinationViewController as! ArticleViewController
            let cell = sender as! ArticleTableViewCell
            destVC.chosenArticle = cell.link
            destVC.articleTitle = cell.articleName.text
        }
    }

}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleNameCell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        item = feedCollector!.feedItems[indexPath.row] as MWFeedItem
        println(item!.link)
        
        cell.link = item!.link
        
        cell.articleName.text = item!.title
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedCollector!.feedItems.count
    }
    
}

extension ArticleListViewController: UITableViewDelegate {
    
}
