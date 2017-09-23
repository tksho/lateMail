//
//  AppDelegate.swift
//  lateMail
//
//  Created by nttr on 2017/08/23.
//  Copyright © 2017年 net.tksho. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let ud = UserDefaults.standard
        let isFirstLaunch = ud.bool(forKey: "isFirstLaunch")
        
        // 初回起動なら
        if isFirstLaunch == false {
            // デフォルト値を保存
            let mail: Mail = Mail(title:"<名前></名前>、遅刻", body: "お疲れ様です。\n<名前></名前>です。\n\nすみませんが<理由></理由>により、\n<遅延時間></遅延時間>ほど遅れます。\n\nすみませんがよろしくお願いします。", fromName: "佐藤", to1: "", to2: "", to3: "", cc1: "", cc2: "", cc3: "", bcc1: "", bcc2: "", bcc3: "" )
            mail.saveToUd()

            // 初回起動したことを記録
            ud.set("true", forKey: "isFirstLaunch")
            ud.synchronize()

            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Intro", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "intro")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "Slide")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

