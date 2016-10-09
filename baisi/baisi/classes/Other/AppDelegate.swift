//
//  AppDelegate.swift
//  baisi
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 ssc. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let tabBarVc = SLETabBarController()
        window?.rootViewController = tabBarVc
        tabBarVc.delegate = self
        window?.makeKeyAndVisible()
        
        SLEPushGuideView.sle_showGuideView()
        return true
    }
    
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("SLETabBarControllerDidSelectedKey", object: nil)
    }
    
    
}





func SLELog<T>(message :T,file :String = #file, method:String = #function,line:Int = #line){

    #if SLEDEBUG
    let fileName = (file as NSString).pathComponents.last!
    print("\(fileName)-\(method)-\(line)-\(message)")
    #endif
}