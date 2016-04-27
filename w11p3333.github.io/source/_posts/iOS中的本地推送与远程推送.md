---
title: iOS中的本地推送与远程推送
date: 2016-04-07

---

<!--more-->
---

### 本地推送
#### 第一步
在AppDelegate中

```swift

//添加本地推送
if #available(iOS 8.0, *) {
let uns =     UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
UIApplication.sharedApplication().registerUserNotificationSettings(uns)
}
```


#### 第二步
在需要推送的事件里

```swift
let localNotification = UILocalNotification()
//推送的文字内容
localNotification.alertBody = "你已经完成了一个番茄钟啦"
//app名字
if #available(iOS 8.2, *) {
localNotification.alertTitle = "Pomodoro"
} else {
// Fallback on earlier versions
}
//app右上角的红标
localNotification.applicationIconBadgeNumber = 1
//通知时的音效
localnotification.soundName = "buyao.wav
//滑动的事件提示
localNotification.alertAction = "输入任务内容"

//立即发送推送
UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
```

#### 如果要设置特定时间发送

```swift
//通知触发时间
localNotification.fireDate = NSDate(timeInterval: <#T##NSTimeInterval#>, sinceDate: <#T##NSDate#>)
//添加推送
UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
```
 
#### 第三步

```

//设置当用户切回app时的操作
func applicationDidBecomeActive(application: UIApplication) {
// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//删除通知
application.cancelAllLocalNotifications()
//让角标消失
application.applicationIconBadgeNumber = 0
}

```  
 
### 推送有关的方法
```	
1.func applicationWillResignActive(application: UIApplication){} //当App既将进入后台、锁屏、有电话进来时会触发此事件
    
2.func applicationDidEnterBackground(application: UIApplication) {} //当App进入后台时触发此事件
    
3.func applicationWillEnterForeground(application: UIApplication) {} //当App从后台即将回到前台时触发此事件
    
4.func applicationDidBecomeActive(application: UIApplication) {}  //当App变成活动状态时触发此事件
    
5.func applicationWillTerminate(application: UIApplication) {} //当App退出时触发此方法，一般用于保存
```

### 远程推送
占坑 有空更