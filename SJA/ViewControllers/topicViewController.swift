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
    
    var currentTopic: String?
    var feedArray: [String] = []
    
    var delegate: FeedCollectorDelegate! = nil
    
    var feedCollector: FeedCollector?
    
    var item: MWFeedItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        println(currentTopic!)
        self.title = currentTopic
        
        //read through sources dictionary from supporting files
        var sourcesDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("Sources", ofType: "plist") {
            sourcesDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = sourcesDict {
            feedArray = dict[currentTopic!] as! Array //casts plist array to array of strings
            println("Point A")
            feedCollector = FeedCollector(listOfURLs: feedArray)
            println("Point B")
        }
        
        // Take out range of topic view controllers in between current and main
        if let navigationController = navigationController {
            var navControllers = navigationController.viewControllers
            if navControllers.count > 2 {
                navControllers.removeRange(1..<(navControllers.count - 1))
                navigationController.viewControllers = navControllers
            }
        }
        
        articleTableView.dataSource = self
        articleTableView.delegate = self
        menuContainer.hidden = true
        
        feedCollector?.createFeedHelpers()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //feedParser.request()
        
        self.articleTableView.reloadData()
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
    
    // segue to aricleviewcontroller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "ArticleClick") {
                let destVC = segue.destinationViewController as! ArticleViewController
                let cell = sender as! ArticleTableViewCell
                destVC.chosenArticle = cell.link
                destVC.articleTitle = cell.articleName.text
        }
    }
    
}

extension TopicViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleNameCell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        item = feedCollector!.feedItems[indexPath.row] as MWFeedItem
        println(item!.link)
        
        cell.link = item!.link
        
        cell.articleName.text = item!.title
        //cell.articleSource.text =
        
        return cell
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedCollector!.feedItems.count
    }
    
}

extension TopicViewController : UITableViewDelegate {

}
