---
title: UI分析利器 Reveal的破解及使用
date: 2016-03-28
---
<!--more-->
---

话不多说 当然，有能力的还是支持正版
[下载地址][1]
[破解包][2]
下载完之后将软件运行一次并用Finder拖到应用程序里
右键显示包内容，再点击contents>MAC OS
将Reveal文件改名，再把解压出来的破解包内容拷进去
重新打开软件 破解成功
点击window>show Reveal library in Finder>ios


![此处输入图片的描述][3]


此时打开了Reveal.framework
将framework拖入需要使用Reveal分析的XCode程序里
注意一定要勾选copy if needed
再点击项目配置 找到Linked Frameworks and Libraries
![此处输入图片的描述][4]


 把Reveal.framework给移除掉
再点击Bulid Settings 搜索Other Linker Flags
加入如下一行

        -ObjC -framework Reveal
然后运行程序，再到Reveal界面中选择你当前运行的模拟器![此处输入图片的描述][5]
ok 大功告成
![此处输入图片的描述][6]


  [1]: http://upload-images.jianshu.io/upload_images/1449048-4e7ea3b4f6181571.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
  [2]: http://upload-images.jianshu.io/upload_images/1449048-4e7ea3b4f6181571.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
  [3]: http://upload-images.jianshu.io/upload_images/1449048-4e7ea3b4f6181571.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
  [4]: http://upload-images.jianshu.io/upload_images/1449048-0e6a828ae033accb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
  [5]: http://upload-images.jianshu.io/upload_images/1449048-6145315f65f25c26.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
  [6]: http://upload-images.jianshu.io/upload_images/1449048-dd91f6194005e0c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240