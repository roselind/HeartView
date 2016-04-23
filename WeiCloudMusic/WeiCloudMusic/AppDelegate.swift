//
//  AppDelegate.swift
//  WeiCloudMusic
//
//  Created by 卢良潇 on 16/3/27.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import KGFloatingDrawer
import AVFoundation



let bgcolor = UIColor(red: 32/255, green: 142/255, blue: 115/255, alpha: 1.0)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        //设置后台播放
        let session = AVAudioSession.sharedInstance()
        try!  session.setCategory(AVAudioSessionCategoryPlayback)
        try!  session.setActive(true)
        
        setupUI()
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = drawerViewController
        window?.makeKeyAndVisible()
              return true
    }

    
    func setupUI()
    {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        //选中背景颜色
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        //字体颜色
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        //背景颜色
        UINavigationBar.appearance().barTintColor = bgcolor
        //返回键颜色
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        // 标题颜色
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        UINavigationBar.appearance().titleTextAttributes = navigationTitleAttribute as? [String: AnyObject]
   
    }
    
    
    private var _drawerViewController: KGDrawerViewController?
    var drawerViewController: KGDrawerViewController {
        get {
            if let viewController = _drawerViewController {
                return viewController
            }
            return prepareDrawerViewController()
        }
    }
    
    func prepareDrawerViewController() -> KGDrawerViewController {
        
        let drawerViewController = KGDrawerViewController()
        drawerViewController.centerViewController = viewControllerForStoryboardId("center")
        drawerViewController.leftViewController = viewControllerForStoryboardId("leftvc")
        drawerViewController.leftDrawerWidth = CGFloat(150)
       
        //背景图片
        
        
        _drawerViewController = drawerViewController
        return drawerViewController
    }
    private func drawerStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
    
    private func viewControllerForStoryboardId(storyboardId: String) -> UIViewController {
        let viewController: UIViewController = drawerStoryboard().instantiateViewControllerWithIdentifier(storyboardId) as! UIViewController
        return viewController
    }
}

