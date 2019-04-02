//
//  AppDelegate.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-09.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = (window?.rootViewController as! UINavigationController).topViewController as! ArticlesViewController
        let vm = ArticlesViewModel(modelService: ArticlesModelController(reachability: Reachability(), session: URLSession.shared))
        vc.setViewModel(vm: vm)
        return true
    }

}

