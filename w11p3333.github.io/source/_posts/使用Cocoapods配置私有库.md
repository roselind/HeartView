---
title: 使用Cocoapods配置私有库
date: 2016-05-19 22:24:19

---

在团队开发中,经常会抽出内部框架以便团队复用,使用Cocoapods制作一个私有的框架,其它同事导入就可以使用了,可以大大提升开发效率。

<!--more-->

# 一、创建两个git仓库

一个用来做私有的Spec Repo在此命名为KAYREPO，一个作为公共仓库在此命名为KAYGIT
# 二、添加私有Repo到Cocoapods

主要命令是pod repo add REPO_NAME SOURCE_URL。其中，REPO_NAME是私有repo的名字也就是KAYREPO，取一个容易记住的名字，后面还会用到，以后公司内部的组件对应的podspec都可以推送到这个repo中；SOURCE_URL就是刚刚我们创建的公共仓库链接。

# 三、制作podspec

在开发中完成了一个框架测试通过发布release版本后，便可以制作podspec。制作方法很多，可以通过XCode中Cocoapods插件的create/edit spec选项来生成，也可以使用命令行:

```
pod spec create PODSPECNAME
```
# 四、编写podspec

这一步我踩了很多坑，测试一直通不过，最终试验成功如下：

```
Pod::Spec.new do |s|
# 库的名称，也就是pod 'NAME' 中的名字
  s.name     = 'CIAccountLib'
# 版本号 注意一定要与仓库中相同 否则测试无法通过
  s.version  = '2.0'
# 协议 不用管
  s.license  = 'MIT'
# 简介 随便写
  s.summary  = 'CIAccountLib is a request util based on AFNetworking and Reachability'
# 项目主页
  s.homepage = 'http://git.nibaguai.com/nbg_service/AccountClientiOS'
# 作者名与邮箱
  s.author   = { 'luliangxiao' => 'luliangxiao@corp-ci.com' }
# 库的地址,也就是从这个地址下载
  s.source   = { :git => 'http://git.nibaguai.com/nbg_service/AccountClientiOS.git', :tag => '2.0' }
# 平台
  s.platform     = :ios, '7.0'
# 注意:就是这点容易掉坑 CIAccountLib代表当前目录，/*表示包含目录中的所有文件,二三级目录也要写出来 .{h,m}表示只筛选h、m文件
  s.source_files = 'CIAccountLib/**/*.{h,m}'
# 依赖的静态库
  s.framework = 'UIKit'
# 支持arc
  s.requires_arc = true  
# 依赖的其它三方框架 系统会自动同时导入
  s.dependency 'AFNetworking', '~> 2.6.3'
  s.dependency 'Reachability', '~> 3.2'
end
```

# 五、测试
推送到服务器前必须要测试通过,cd到与spec文件同级目录,命令行敲上以下命令:

```
pod lib lint
```

执行此过程会调用xcode命令行自动编译,只有编译通过才能进入下一步

显示具体错误使用:

```
--verbose
```
若提示警告可以忽视:

```
--allow-warnings
```

无错误则为测试通过

# 六、推送到服务器

推送命令如下:

```
pod repo push REPO_NAME SPEC_NAME.podspec
```

REPO_NAME就是建立的私有repo，也就是KAYREPO 
忽视警告同样使用  

```
--allow-warnings
```
 
无错误则为推送成功

测试下能否搜索到lib:


```
pod search NAME
``` 


若成功类似如下:

```
$ pod search KAYUTIL
-> KAYUTIL (0.1.2)
   KAYUTIL is a request util based on AFNetworking
   pod 'BGNetwork', '~> 0.1.2'
   Homepage: https://github.com/luliangxiao/KAYUTIL
   Source:   https://github.com/luliangxiao/KAYUTIL.git
   Versions: 0.1.1, 0.1.0 [luliangxiao repo] - 0.1.2, 0.1.1 [master repo]
```

同时将sepc文件PUSH到远程KAYGIT仓库中,以后版本更新就PUSH新的sepc文件到KAYGIT



# 七、导入

若要在项目中导入上传的私有库，需要在Podfile文件中添加本地私有源。如果没有添加本地私有源，它默认是用官方的repo，这样找不到本地的Pod；如果只是设置了本地私有源，就不会再去官方源中查找。在podfile中配置如下:

```
#官方Cocoapods的源
source 'https://github.com/CocoaPods/Specs.git'
#本地私有源
source 'http://git.kay.com/luliangxiao/cocospod_spec_repo.git'
platform :ios, '7.0'
pod ‘KAYUTIL’, '~> 2.0'

```
执行pod install. KO