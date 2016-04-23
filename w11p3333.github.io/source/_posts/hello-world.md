---
title: CocoaPods及Carthage的使用
date: 2016-04-16
---
作为iOS中最好用的两个依赖管理，是我们必须学会的。使用上来说CocoaPods更加方便，Carthage的侵入性比较低，但是很多库没有，所以我个人还是使用Cocoapods为主。
<!--more-->
# Cocoapods基于Alcatraz安装CocoaPods报错的问题
用Alcatraz安装CocoaPods，执行install pods命令会报错

		Resolved command path for "pod" is invalid。
原因：软件云被屏蔽
解决方法：把亚马逊的云服务改成国内淘宝源的服务
打开Terminal，然后键入以下命令：

		$ sudo gem install -n /usr/local/bin cocoa pods
执行完这句如果报告错误
这是因为ruby的软件源rubygems.org因为使用亚马逊的云服务，被屏蔽了，需要更新一下ruby的源，过程如下：

	 $ gem sources -l (查看当前ruby的源)
	 $ gem sources --remove https://rubygems.org/ 
	  $ gem sources -a https://ruby.taobao.org/ 
	  $ gem sources -l
如果gem太老，可以尝试用如下命令升级

	gem $ sudo gem update --system
升级成功后会提示:

	RubyGems system software updated
然后重新执行安装下载命令

	$ sudo gem install cocoapods
这时候应该没什么问题了接下来进行安装，执行：

	$ pod setup
Terminal会停留在 Setting up CocoaPods master repo 这个状态一段时间,是因为要进行下载安装,而且目录比较大,需要耐心等待一下。看到complete字段就是安装成功了

导入框架方法
点击Xcode>Product>Cocoapods>create podfile

填入想导入的框架

		platform :ios, "8.0"

		use_frameworks!
		pod "AFNetworking"
在执行Install pods就ok了

# Carthage
安装

 	   brew install carthage
使用
1.进入项目所在文件夹
2.创建一个空的carthage文件

  		  touch Cartfile
3.使用XCode打开文件

  		  open -a Xcode Cartfile
4.编辑Cartfile

 	 	  github "SVProgressHUD/SVProgressHUD"
5.运行Carthage

  		  carthage update
6.加载framework
    在项目文件夹中找到Carthage/Build/iOS/
    将需要的framework加入xcode中的Embedded Binaries
或者
    在项目中引入依赖的 Framkework，只需要在对应 Target 中的 Build Setting 中的 Framework Search Path 项加入以下路径，Xcode 便会自动搜索目录下的 Framework：

    $(SRCROOT)/Carthage/Build/iOS
7.导入框架使用吧
