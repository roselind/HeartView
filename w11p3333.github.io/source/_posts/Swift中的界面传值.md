
---
title: Swift中的界面传值
date: 2016-03-20

---

<!--more-->
---

### 正向页面传值-通过代码
```
有A、B两个控制器，A要把文本的里的string传给B 
在B中定义一个属性
var txtStr
//在A要进入B控制器的操作中 
var secondVC:SecondViewController = SecondViewController() 
secondVC.txtStr = self.text 
presentViewController(secondVC , animated: true, completion: nil)
//在B中要显示的控件中赋值 
self.label.text = txtStr
```

### 正向传值第二种方法
```
有A、B两个控制器，A要把文本的里的string传给B
//在B中定义一个属性
var txtStr
//在B中重写init()方法
init(text:String)
{
self.txtStr = text
super.init(nibName: nil, bundle: nil)
}
//在A要进入B控制器的操作中
var secondVC:SecondViewController = SecondViewController(text:self.text)
presentViewController(secondVC , animated: true, completion: nil)
//在B中要显示的控件中赋值
self.label.text = txtStr
```

### 正向页面传值第三种方法-通过Storyboard

```
有A、B两个控制器，A要把文本的里的string传给B
两个 View 之间要用 Modal 类型的 Segue 来连接
//在B中定义一个属性
var txtStr
//在A中重写prepareForSegue方法
  let destVc: secondVC:SecondViewController = segue.destionViewController as! secondVC:SecondViewController
//将A中的值赋值到B中的属性
destVc.textStr = self.text
//在B中要显示的控件中赋值
 self.label.text = txtStr
```
### Delegate反向传值
```
谁要传值谁就拥有代理属性
有A、B两个控制器，A进入B，B再返回A，把文本里的String传给A
在A中定义一个属性
var txtStr:String?
给B定义一个协议
protocol SecondVcDelegate:NSObjectProtocol
{
func SecondVcGiveTextToFirstVc(text: String)

}
再给B定义一个delegate 避免循环应用要加上weak
weak var delegate:SecondVcDelegate?
在B要跳转回A的时候调用代理
self.delegate?.SecondVcGiveTextToFirstVc("test")
在A中需要接受值的时候
let vc = SecondVc()
vc.delegate = self
extension FirstVc:delegate:SecondVcDelegate
{
func SecondVcGiveTextToFirstVc(text: String)
{
txtStr = text
}
}
```
### NSNotificationCenter传值

#### 第一步 post一个通知
```swift
let info = [WDPictureWillOpen:pictureTopic!.cdn_img!]
NSNotificationCenter.defaultCenter().postNotificationName(WDPictureWillOpen, object: self, userInfo: info)
```
#### 第二步 接受通知
```swift
NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(WDPictureTableViewController.openPothoBrowser(_:)), name: WDPictureWillOpen, object: nil)
```
#### 第三步 实现接受通知的方法并拿到值
```swift
func openPothoBrowser(notify: NSNotification)
{

//一定要拦截
guard let urlstr = notify.userInfo![WDPictureWillOpen] as? String  else
{
return
}

}
```
#### 第四步 一定要移除通知
```swift
deinit
{
NSNotificationCenter.defaultCenter().removeObserver(self)
}
```      
### NSUserDefault传值
注意：NSUserDefaults是持久化存储 
```
//在需要传值的地方      
NSUserDefaults.standardUserDefaults().setObject("test", forKey: "test") 
//取出值
let str = NSUserDefaults.standardUserDefaults().objectForKey("test") print(Str)
```       
### 闭包传值
### 单例传值
占坑 有空再更