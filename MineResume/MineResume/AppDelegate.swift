//
//  AppDelegate.swift
//  MineResume
//
//  Created by 卢良潇 on 16/3/24.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarHidden = true
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        // Override point for customization after application launch.
        return true
    }



}

