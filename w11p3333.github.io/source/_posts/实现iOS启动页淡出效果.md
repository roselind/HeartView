---
title: 实现iOS启动页淡出效果
date: 2016-04-21 22:08:21
tags: 干货
---





 
先上Demo：https://github.com/w11p3333/LaunchDemo

思路：将launchScreen作为window的一个addsubview

<!--more-->
实现：
1.在LaunchScreen中将Storyboard ID设置为Launch
2.实现方法
    
```` swift
 private func launchAnimation()
    {

    let vc = UIStoryboard(name:"LaunchScreen", bundle:nil).instantiateViewControllerWithIdentifier("Launch")
    let launchview = vc.view
    let delegate = UIApplication.sharedApplication().delegate
    let mainWindow = delegate?.window
    mainWindow!.addSubview(launchview)
    UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
    launchview.alpha = 0.0
    launchview.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
    }) { (finished) in
    launchview.removeFromSuperview()
    }
      }

````

   若是应用使用storyboard中加载的，需要在初始界面的viewcontroller的viewDidAppear方法中调用。

若是应用从代码中加载的，需要在AppDelegate中didFinishLaunchingWithOptions方法中调用 
</div>
