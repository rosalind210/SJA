//
//  AppDelegate.swift
//  SJA
//
//  Created by Rosalind Ellis on 7/15/15.
//  Copyright (c) 2015 Rosalind Ellis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var url: String?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //LOAD RANDOM ARTICLE
        //read through sources dictionary
        var sourcesDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("Sources", ofType: "plist") {
            sourcesDict = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = sourcesDict {
            //get topic
            let topicArray = dict.allKeys as! [String]
            let numForTopic = Int(arc4random_uniform(UInt32(topicArray.count))) //get random number between 0 and the number of keys
            let topic = topicArray[numForTopic]
            let topicDict = dict[topic] as! NSDictionary //get the topic from the array
            
            //get website
            let webArray = topicDict.allKeys as! [String]
            let numForWeb = Int(arc4random_uniform(UInt32(webArray.count)))
            let website = webArray[numForWeb]
            
            //get feed
            let feeds = topicDict[website] as! [String]
            let randomFeed = Int(arc4random_uniform(UInt32(feeds.count)))
            let feed = feeds[randomFeed]
            let feedUrls = FeedHelper(givenURL: feed)
            //get article from feed
            let randomArticle = Int(arc4random_uniform(UInt32(feedUrls.feedItems.count)))
            url = feedUrls.feedItems[randomArticle].link
            println(url)
        }
        
        // Change status bar to white
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

