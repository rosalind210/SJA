//
//  ArticleViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var chosenArticle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let url = NSURL(fileURLWithPath: chosenArticle!)
        let url = NSURL(string: chosenArticle!)
        
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
