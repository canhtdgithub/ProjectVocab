//
//  AppDelegate.swift
//  Reminder
//
//  Created by Cata on 08/26/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        let navi = UINavigationController(rootViewController: viewController)
        
        let addviewController = AddViewController()
        let navi1 = UINavigationController(rootViewController: addviewController)
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [navi, navi1]
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        return true
    }

}

