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
    
    var blurEffect = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = chosenWebsite
        
        //read through sources dictionary from supporting files
        if let dict = websiteDict {
            feedArray = websiteDict![chosenWebsite!] as! [String]
            feedCollector = FeedCollector(listOfURLs: feedArray)
        }
        
        articleListTableView.dataSource = self
        articleListTableView.delegate = self
        menuContainer.hidden = true
        
        backgroundThread(background: {
            //in the background
            self.feedCollector?.createFeedHelpers()
//            NSNotification(name: "Loading Screen", object: <#AnyObject?#>)
        }, completion: {
            //when done
            self.articleListTableView.reloadData()
        });
        
    }
    
    //var alert: UIAlertView = UIAlertView(title: "Title", message: "Please wait...", delegate: nil, cancelButtonTitle: "Cancel");
//    var alert = UIAlertView()
//    var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
//    loadingIndicator.center = self.view.center;
//    loadingIndicator.hidesWhenStopped = true
//    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//    loadingIndicator.startAnimating();
//    
//    alert.setValue(loadingIndicator, forKey: "accessoryView")
//    loadingIndicator.startAnimating()
//    
//    alert.show();
//    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        blurEffect.frame = self.view.bounds
        self.view.insertSubview(blurEffect, aboveSubview: articleListTableView)
        blurEffect.hidden = true
    }
    
    @IBAction func menuAction() {
        if menuContainer!.hidden {
            menuContainer!.hidden = false
            blurEffect.hidden = false
        } else {
            menuContainer!.hidden = true
            blurEffect.hidden = true
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
        
        cell.link = item!.link
        
        cell.articleName.text = item!.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedCollector!.feedItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        articleListTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension ArticleListViewController: UITableViewDelegate {
    
}
