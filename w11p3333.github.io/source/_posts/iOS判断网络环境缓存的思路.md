---
title: iOS判断网络环境缓存的思路
date: 2016-05-17 23:28:59

---
使用SDWebImage如何控制该缓存怎样大小的图片？

<!--more-->
伪代码思路：

```objc
- setItem:(CustomItem *)item
{
_item = item;

if (缓存中有原图) 
{
self.imageView.image = 原图;
} else 
{
if (Wifi环境) 
{
下载显示原图
} else if (手机自带网络) 
{
if (3G\4G环境下仍然下载原图) 
{
    下载显示原图
} else 
{
    下载显示小图
}
} else 
{
if (缓存中有小图) 
{
    self.imageView.image = 小图;
} else  // 处理离线状态
{
    self.imageView.image = 占位图片;
}
}
}
}
``` 
    
使用AFN和SDWebimage的完整代码

```objc
- setItem:(CustomItem *)item
{
_item = item;

// 占位图片
UIImage *placeholder = [UIImage imageNamed:@"placeholderImage"];

// 从内存\沙盒缓存中获得原图
UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.originalImage];
if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
} else { // 内存\沙盒缓存没有原图
AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
} else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
//     用户的配置项假设利用NSUserDefaults存储到了沙盒中
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
if (alwaysDownloadOriginalImage) { // 下载原图
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
} else { // 下载小图
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
}
} else { // 没有网络
UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.thumbnailImage];
if (thumbnailImage) { // 内存\沙盒缓存中有小图
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
} else {
    [self.imageView sd_setImageWithURL:nil placeholderImage:placeholder];
}
}
}
}
```