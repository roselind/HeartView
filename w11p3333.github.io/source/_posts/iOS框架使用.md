
---
title: iOS中实用框架的使用
date: 2016-04-11
---
介绍一些我常用但是不是很热门的框架：JASON、SwiftyGif
SDCycleScrollView、RxWebViewController、KGFloatingDrawer、AFSoundManager、YZDisplayViewController、FMDB、masonry

<!--more-->

# SDCycleScrollView
https://github.com/gsdios/SDCycleScrollView
实现图片轮播框架
使用方法
```swift
let imageGroup = ["1","2","3","4","5"]

let scrollview = SDCycleScrollView(frame: CGRectMake(0, 0, (UIScreen.mainScreen().bounds.width), 200), imageNamesGroup: imageGroup)
```
# RxWebViewController
https://github.com/Roxasora/RxWebViewController
仿微信效果的webview
```swift
let vc = RxWebViewController(url: url)
self.navigationController?.pushViewController(vc, animated: true)
```
# KGFloatingDrawer
https://github.com/KyleGoddard/KGFloatingDrawer
实现左右侧边栏框架

#### 1.
```swift
privatevar _drawerViewController: KGDrawerViewController?
```
#### 2.
```swift
var drawerViewController: KGDrawerViewController {  
get {       
if let viewController = _drawerViewController {       
return viewController      
}          

returnprepareDrawerViewController()
}
}
```
#### 3.
```swift
func prepareDrawerViewController() -> KGDrawerViewController {     
let drawerViewController = KGDrawerViewController()    
drawerViewController.centerViewController = viewControllerForStoryboardId("center")

drawerViewController.leftViewController = viewControllerForStoryboardId("leftvc")

drawerViewController.rightViewController = viewControllerForStoryboardId(“rightvc"
)

drawerViewController.leftDrawerWidth = CGFloat(150)       
//背景图片     

_drawerViewController = drawerViewController      
return drawerViewController  
}
```
#### 4.
```swift
private func drawerStoryboard() -> UIStoryboard {   
let storyboard = UIStoryboard(name: "Main", bundle: nil)        return storyboard    }
```
#### 5.
```swift
private func viewControllerForStoryboardId(storyboardId: String) -> UIViewController {     
let viewController: UIViewController = drawerStoryboard().instantiateViewControllerWithIdentifier(storyboardId) as! UIViewController   
return viewController
}
```
#### 最后将
```
window?.rootViewController = drawerViewController
```
#### 在想要弹出的方法里
```swift
let appDelegate = UIApplication.sharedApplication().delegateas! AppDelegate     
appDelegate.drawerViewController.toggleDrawer(KGDrawerSide.Left, animated: true) { (finished) -> Void            in
}
```
# AFSoundManager
https://github.com/AlvaroFranco/AFSoundManager
音乐播放框架
```swift
var player:AFSoundPlayback?

//开始播放音乐 


AFSoundManager.sharedManager().startStreamingRemoteAudioFromURL(musicurl) { (percentage, elapsedTime, timeRemaining, error, finished) in


//进度 percentage
//  elapsedTime 开始时间
//  timeRemaining 结束时间
}
```
### 暂停方法

    AFSoundManager.sharedManager().pause()
### 重播方法

    AFSoundManager.sharedManager().resume()
# MJRefresh
https://github.com/CoderMJLee/MJRefresh

刷新控件框架

```swift
/// header    var header:MJRefreshNormalHeader{  
return (self.tableView.tableHeaderViewas? MJRefreshNormalHeader)!  
}   

/**  footer  */ 
var footer:MJRefreshFooter{   
return (self.tableView.tableFooterViewas? MJRefreshFooter)!

}
```
#### 方法中
```swift
func  setUpRefrshControl()    {       
/**        上拉刷新        */   
tableView.tableHeaderView = MJRefreshNormalHeader.init(refreshingBlock: { () -> Voidin            self.footer.endRefreshing()

self.tableView.reloadData()     

self.header.endRefreshing()               

})    
header.automaticallyChangeAlpha = true     
header.beginRefreshing()    
/**        下拉刷新        */         
tableView.tableFooterView = MJRefreshAutoNormalFooter.init(refreshingBlock: { () -> Void in      
self.header.endRefreshing()  

self.footer.beginRefreshing()

self.tableView.reloadData()                self.footer.endRefreshing()               

})       

}
```
# YZDisplayViewController
滑动标题栏框架
https://github.com/iThinkerYZ/YZDisplayViewController

```swift
/**
设置标题样式
*/
func setupTitle()
{

isShowUnderLine = true
underLineColor = bgcolor
isShowTitleGradient = true
isShowTitleCover = false

titleHeight = 38
endR = 32 / 255.0
endG = 142 / 255.0
endB = 115 / 255.0

// 是否显示遮盖
titleScrollViewColor = UIColor.whiteColor()

coverColor = UIColor(white: 0.7, alpha: 0.4)
coverCornerRadius = 13
norColor = UIColor.blackColor()
selColor = UIColor.whiteColor()
}



/**
添加子控制器
*/
func setupAllControllers()
{
let text = WDTextTableViewController()
text.title = "糗事"
addChildViewController(text)
let picture = WDPictureTableViewController()
picture.title = "图片"
addChildViewController(picture)
let video = WDVideoTableViewController()
video.title = "视频"
addChildViewController(video)
}
```

# FMDB
不能用cocoa pod导入
先从github下好拖进工程里
再创建一个桥接文件 swift-brige
在设置中添加sqlite3 库
在build settings中搜索Bridging Header
添加桥接文件的路径（在本工程内的路径）
使用FMDatabaseQueue相比FMDatabase是数据安全的，并且不需要打开数据库的流程

# masonry
实现方便的代码实现autolayout
使用方法
有make remake update三种方法 传进去的参数要加mas_前缀 mas_equalTo 会对参数进行包装 equalTo 不会对参数进行包装

```swift
//尺寸约束
make.size.as_equalTo(CGSizeMake(x,y)); 
//位置约束 居中
make.centerX.mas_equalTo(self.view.centerX);    
make.centerY.mas_equalTo(self.view.centerY); 
//设置到边的距离      
make.right.mas_euqalTo(self.view).offset(20);
```
#
# Parse for iOS 
为ios提供后端
用法：http://www.mobile-open.com/2015/41095.html
官网：
https://parse.com/docs/cn/ios/guidehttp://zhuanlan.zhihu.com/p/19597061
# LeanClound
# Realm
# Spring
# SwiftyGif
# JASON
一些常用的SVProgressHUD/AFN/Alamofire/SDWebImage
的使用都比较简单我这里就暂时不写了

不定时更新
