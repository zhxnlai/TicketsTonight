//
//  AppDelegate.swift
//  Tickets Tonight
//
//  Created by Zhixuan Lai on 11/13/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var navController: UINavigationController!
    var tabBarController: UITabBarController!
    var feedViewController: TTFeedTableViewController!
    var favoriteViewController: TTFavoriteTableViewController!
    var exploreViewController: TTExploreViewController!
    var settingsViewController: TTSettingsTableViewController!
    
    // MARK: - App Delegate
    func presentTabBarController() {
        self.tabBarController = UITabBarController()
        
        self.feedViewController = TTFeedTableViewController(style: .Plain)
        self.favoriteViewController = TTFavoriteTableViewController(style: .Plain)
        self.exploreViewController = TTExploreViewController()
        self.settingsViewController = TTSettingsTableViewController(style: .Grouped)
        
        self.feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "IconInbox"), selectedImage: UIImage(named: "IconInboxSelected"))
        self.favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "IconArtist"), selectedImage: UIImage(named: "IconArtistSelected"))
        self.exploreViewController.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "IconLightning"), selectedImage: UIImage(named: "IconLightningSelected"))
        self.settingsViewController.tabBarItem = UITabBarItem(title: "More", image: UIImage(named: "IconList"), selectedImage: UIImage(named: "IconListSelected"))

        self.feedViewController.navigationItem.title = "Feed"
        self.favoriteViewController.navigationItem.title = "Favorite"
        self.exploreViewController.navigationItem.title = "Explore"
        self.settingsViewController.navigationItem.title = "More"
        
        var feedNav = UINavigationController(rootViewController: feedViewController)
        var favoriteNav = UINavigationController(rootViewController: favoriteViewController)
        var exploreNav = UINavigationController(rootViewController: exploreViewController)
        var settingsNav = UINavigationController(rootViewController: settingsViewController)
        
        self.tabBarController.viewControllers = [feedNav, favoriteNav, exploreNav, settingsNav]
        
        self.navController.navigationBarHidden = true
        self.navController.pushViewController(self.tabBarController, animated: false)
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("Iw6cWX4qJy5Zkp4uDIevWI5sF1BD0JZ3uxQyCUz2", clientKey: "IYVV1tMlbQqOWmsbGvG7lLqVGeCmifZ3tRaiNZDK")
        Parse.offlineMessagesEnabled(false)
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        var defaultACL = PFACL()
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        if application.applicationIconBadgeNumber != 0 {
            application.applicationIconBadgeNumber = 0
            PFInstallation.currentInstallation().saveEventually()
        }
        
        PFUser.enableAutomaticUser()
        PFUser.currentUser().incrementKey(kTTUserRunCountKey)
        PFUser.currentUser().saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                
            }
        }
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {            
            
//            [[UINavigationBar appearance] setBarTintColor:[UIColor flatPeterRiverColor]];
//            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//            //    [[UINavigationBar appearance] setTranslucent:NO];
//            [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
            
            
            UINavigationBar.appearance().barTintColor = kTTBarColor
            UINavigationBar.appearance().tintColor = UIColor.flatCloudsColor()
            UINavigationBar.appearance().barStyle = .Black
            
            
            UITabBar.appearance().barTintColor = kTTBarColor
            //            UITabBar.appearance().tintColor = UIColor.flatCloudsColor()
            UITabBar.appearance().barStyle = .Black

            UITabBar.appearance().tintColor = UIColor.flatAlizarinColor()
////            UITabBar.appearance().tintColor = UIColor.flatMidnightBlueColor()

            self.navController = UINavigationController()
            self.presentTabBarController()
            
            window.makeKeyAndVisible()
            window.rootViewController = self.navController
        }
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

