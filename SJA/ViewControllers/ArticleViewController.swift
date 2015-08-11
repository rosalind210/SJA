//
//  ArticleViewController.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import WebKit

class ArticleViewController: UIViewController {
    
    var webView: WKWebView!  = WKWebView()
    var chosenArticle: String?
    var articleTitle: String?
    var randomURL: String?
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    
    var blurEffect = UIVisualEffectView()
    
    //FOR RANDOM ARTICLE
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var randomButton: UIBarButtonItem!
    
    // initializes webView with frame size zero
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: CGRectZero)
        
        // hides navigation bar when scrolling
        self.shyNavBarManager.scrollView = webView.scrollView
        
        if articleTitle != nil {
            self.title = articleTitle
        } else {
            self.title = "Random Article"
        }
        
        // adds webview to main view below the progress view
        view.insertSubview(webView, belowSubview: progressView)
        
        // sets constraints of webview
        webView.setTranslatesAutoresizingMaskIntoConstraints(false) //disables autogenerated layout
        
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -44) // define height equal to the toolbar
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0) // define width equal to superview
        view.addConstraints([height, width]) //adds constraints to view
        webView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        
        // creates and loads article link
        if chosenArticle == nil { //if this is the main screen
            randomURL = randomArticle()
            let url = NSURL(string: randomURL!)
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj)
        } else { //if this is coming from the tvc
            let url = NSURL(string: chosenArticle!)
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        blurEffect.frame = view.bounds
        webView.addSubview(blurEffect)
        blurEffect.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        // hides navigation bar when scrolling
//        navigationController?.hidesBarsOnSwipe = true
        self.shyNavBarManager.scrollView = webView.scrollView
        
        //buttons are definitely not enabled
        backButton.enabled = false
        forwardButton.enabled = false
        
        //observers
        webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        if menuContainer != nil {
            menuContainer.hidden = true
        }

    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: "loading")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.removeFromSuperview()
        
        //hide the menu and blur after pressing topic
        if menuContainer != nil {
            menuContainer.hidden = true
            blurEffect.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Loading Property
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
        
        // updates progressView to the estimated progress
        if keyPath == "estimatedProgress" {
            progressView.hidden = (webView.estimatedProgress == 1)
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    // resets progressView after each request
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
    
    // MARK: - Navigation Controller for opening screen
    @IBAction func menuAction() {
        if menuContainer!.hidden {
            menuContainer!.hidden = false
            blurEffect.hidden = false
        } else {
            menuContainer!.hidden = true
            blurEffect.hidden = true
        }
    }

    
    // MARK: - Toolbar Actions
    
    @IBAction func back(sender:UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func forward(sender:UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func reload(sender:UIBarButtonItem) {
        let request = NSURLRequest(URL: webView.URL!)
        webView.loadRequest(request)
    }
    
    @IBAction func back2(sender: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func forward2(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func refresh2(sender: AnyObject) {
        let request = NSURLRequest(URL: webView.URL!)
        webView.loadRequest(request)
    }
    
    
    //MARK: -random button
    
    @IBAction func getRandomArticle() {
        var newURL = randomArticle()
        if newURL != "" {
            let url = NSURL(string: newURL)
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj)
        } else {
            newURL = randomArticle()
            let url = NSURL(string: newURL)
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj)
        }
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
