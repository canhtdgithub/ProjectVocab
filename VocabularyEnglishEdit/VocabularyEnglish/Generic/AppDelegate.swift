//
//  AppDelegate.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@available(iOS 11.0, *)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let notifi = UNUserNotificationCenter.current()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        testShowNoti()
        IQKeyboardManager.shared.enable = true
        window = UIWindow(frame: UIScreen.main.bounds)
        initTabbar(index: 0)
        window?.makeKeyAndVisible()
        return true
    }
    
    func initTabbar(index:Int) {
        let viewController = ViewController()
        let navi = UINavigationController(rootViewController: viewController)
        navi.tabBarItem.image = UIImage(named: "creat_vocabulary")
        navi.isNavigationBarHidden = true
        navi.title = "Home"
        let gamesController = GamesViewController()
        let navi1 = UINavigationController(rootViewController: gamesController)
        navi1.tabBarItem.image = UIImage(named: "game")
        navi1.title = "Game"
        
        let searchController = SearchViewController()
        let navi3 = UINavigationController(rootViewController: searchController)
        navi3.tabBarItem.image = UIImage(named: "search")
        navi3.title = "Search"
        
        let dictionController = DictionaryViewController()
        let navi4 = UINavigationController(rootViewController: dictionController)
        navi4.tabBarItem.image = UIImage(named: "dictionary")
        navi4.title = "Dictionary"
        
        let settingController = SettingViewController()
        
        let navi2 = UINavigationController(rootViewController: settingController)
        navi2.tabBarItem.image = UIImage(named: "setting")
        navi2.title = "Setting"
        
        UITabBar.appearance().tintColor = UIColor("60c5ba", alpha: 1)
        UITabBar.appearance().barTintColor = .white
        
        
        let tabbarViewController = UITabBarController()
        tabbarViewController.viewControllers = [navi, navi1, navi3, navi4, navi2]
        tabbarViewController.selectedIndex = index
        window?.rootViewController = tabbarViewController
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        notifi.removeAllDeliveredNotifications()
    }
    
    func noti() {
        let content = UNMutableNotificationContent()
        content.title = "Learn a new vocabulary!!!!"
        content.body = "Let's go learning vocabulary. Never give up!!! "
        content.sound = UNNotificationSound.default
        
        var dateInfo = DateComponents()
        
        dateInfo.hour = testShowHour()
        dateInfo.minute = testShowMinute()
        
        dateInfo.timeZone = .current
        
        let trig = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: "thu", content: content, trigger: trig)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func testShowNoti() {
        guard let show = UserDefaults.standard.value(forKey: "show") as? Bool, let arr = UserDefaults.standard.value(forKey: "arrayBool") as? Array<Bool> else {
            return
        }
        
        if show == false {
            let date = Date()
            let a = Calendar.current
            let b = a.component(.weekday, from: date)
            if arr[b - 1] {
                noti()
            }
        }
        
    }
    
    func testShowHour() -> Int {
        guard let hour = UserDefaults.standard.value(forKey: "hour") as? String,
            let ampm = UserDefaults.standard.value(forKey: "ampm") as? String else {
                return 07
        }
        if ampm == "AM" {
            return Int(hour)!
        }
        
        return 12 + Int(hour)!
    }
    
    func testShowMinute() -> Int {
        guard let minute = UserDefaults.standard.value(forKey: "minute") as? String else {
            return 00
        }
        return Int(minute)!
    }
    
}

