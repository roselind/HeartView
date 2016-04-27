---
title: Swift微信摇一摇的实现
date: 2016-04-21 22:08:21
---


<!--more-->
---

先附上demo地址:
[demo][1]
iOS自带了识别摇动的功能，实现起来非常简单，只需要

````swift
  /**
开启摇动感应
*/   UIApplication.sharedApplication().applicationSupportsShakeToEdit = true
    becomeFirstResponder()
    
````

然后只需要实现它的三个方法




	//开始摇动
		override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) 
	//取消摇动
		override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) 
	//结束摇动
		override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?)


了解了方法之后接下来就是我们的实现


# 第一步

首先我们用xib搭建一个界面，注意上下其实是两张图片，等会就是控制它们的frame实现摇动效果，然后我们导入摇一摇的音效


![此处输入图片的描述][2]
# 第二步，连线xib并导入AVFoundation框架并遵守AVAudioPlayerDelegate


````swift

 import AVFoundation
@IBOutlet weak var rockup: UIImageView!
@IBOutlet weak var rockdown: UIImageView!

var player: AVAudioPlayer?

````

# 第三步，实现开始动画

````swift

   /**
 开始摇动
 */
override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {

print("开始摇动")

//开始动画
 UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in

 self.rockup.frame.origin.y -= 80
self.rockdown.frame.origin.y += 80

}, completion: nil)
    /// 设置音效
    let path1 = NSBundle.mainBundle().pathForResource("rock", ofType:"mp3")
    let data1 = NSData(contentsOfFile: path1!)
    self.player = try? AVAudioPlayer(data: data1!)
    self.player?.delegate = self
    self.player?.updateMeters()//更新数据
    self.player?.prepareToPlay()//准备数据
    self.player?.play()

//结束动画
    UIView.animateKeyframesWithDuration(0.5, delay: 1.0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in

 self.rockup.frame.origin.y += 80
self.rockdown.frame.origin.y -= 80

}, completion: nil)

    }
    实现取消方法

       /**
     取消摇动
     */
 override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) {

 print("取消摇动")
    SVProgressHUD.showErrorWithStatus("还不够用力哦 请使劲的摇我吧", maskType: SVProgressHUDMaskType.Black)
    }
    实现结束方法，然后可以在此处实现想要摇一摇实现的功能

 /**
摇动结束

 */
override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {

print("摇动结束")
 ///此处设置摇一摇需要实现的功能
    let nav = UINavigationController(rootViewController: WDLoadNearByTableViewController())
    presentViewController(nav, animated: true, completion: nil)

 /// 设置音效
    let path = NSBundle.mainBundle().pathForResource("rock_end", ofType:"mp3")
    let data = NSData(contentsOfFile: path!)
    self.player = try? AVAudioPlayer(data: data!)
    self.player?.delegate = self
    self.player?.updateMeters()//更新数据
    self.player?.prepareToPlay()//准备数据
    self.player?.play()
    }
到此为止一个完整的摇一摇功能就实现了

````

  [1]: https://github.com/w11p3333/shakeDemo/tree/master
  [2]: http://upload-images.jianshu.io/upload_images/1449048-d6b74e5f6685b41b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240