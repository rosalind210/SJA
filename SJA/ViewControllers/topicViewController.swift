//
//  TopicViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    
    
    @IBOutlet weak var websiteListTableView: UITableView!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var currentTopic: String?
    var websites: NSDictionary?
    var websiteArray: [String] = []
    
    var blurEffect = UIVisualEffectView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentTopic
                
        // Take out range of topic view controllers in between current and main
        if let navigationController = navigationController {
            var navControllers = navigationController.viewControllers
            if navControllers.count > 2 {
                navControllers.removeRange(1..<(navControllers.count - 1))
                navigationController.viewControllers = navControllers
            }
        }
        
        //read through sources dictionary from supporting files
        var sourcesDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("Sources", ofType: "plist") {
            sourcesDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = sourcesDict {
            websites = dict[currentTopic!] as? NSDictionary
            websiteArray = websites!.allKeys as! [String]
            websiteArray.sortInPlace { $0 < $1 }
        }
        
        websiteListTableView.dataSource = self
        websiteListTableView.delegate = self
        menuContainer.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        blurEffect.frame = self.view.bounds
        self.view.insertSubview(blurEffect, aboveSubview: websiteListTableView)
        blurEffect.hidden = true
        
        menuContainer.hidden = true
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // segue to aricleviewcontroller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "WebsiteClick") {
                //alert()
                let destVC = segue.destinationViewController as! ArticleListViewController
                let cell = sender as! WebsiteTableViewCell
                destVC.chosenWebsite = cell.website
                destVC.websiteDict = cell.websiteDictionary
        }
    }
    
}

extension TopicViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WebsiteNameCell", forIndexPath: indexPath) as! WebsiteTableViewCell
        
        let row = indexPath.row
        cell.website = websiteArray[row]
        cell.websiteDictionary = websites
        cell.websiteLabel.text = cell.website
        
        return cell
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websiteArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        websiteListTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension TopicViewController : UITableViewDelegate {

}
