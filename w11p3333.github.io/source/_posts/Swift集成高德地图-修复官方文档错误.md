---
title: Swift集成高德地图-修复官方文档错误
date: 2016-04-20

---


估计官方文档很久没更新了，里面好多错的，自己改了下。
首先强烈推荐直接用cocoapod装..不然配置会有很多坑
<!--more-->
1.集成的两个库 libz.dylib libstdc++6.09.dylib改为libz.tbd、libstdc++6.09.tbd、libc++.tbd
2.直接上我改过的代码 亲测可以跑

```swift

import UIKitlet
APIKey = "bb7276ed1dd269c02137458ce32647b9"
class WDMapViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate {  
    
//地图
var mapView:MAMapView?
//搜索
var search:AMapSearchAPI?
//定位
var currentLocation:CLLocation?
override func viewDidLoad() {
super.viewDidLoad()
	
	
	
// 配置用户Key
MAMapServices.sharedServices().apiKey = APIKey
AMapSearchServices.sharedServices().apiKey = APIKey
// 初始化MAMapView
initMapView()
//初始化搜索
initSearch()
	
}
    
    
    
func initMapView(){
	
mapView = MAMapView(frame: self.view.bounds)
	
mapView!.delegate = self
	
	
let compassX = mapView?.compassOrigin.x
	
let scaleX = mapView?.scaleOrigin.x
	
//设置指南针和比例尺的位置
mapView?.compassOrigin = CGPointMake(compassX!, 21)
	
mapView?.scaleOrigin = CGPointMake(scaleX!, 21)
	
mapView?.showsCompass = true
mapView?.showsScale = true
	
// 开启定位
mapView!.showsUserLocation = true
	
// 设置跟随定位模式，将定位点设置成地图中心点
mapView!.userTrackingMode = MAUserTrackingMode.Follow
	
	
//添加视图
self.view.addSubview(mapView!)
	
}
    
    
// 初始化 AMapSearchAPI
func initSearch(){
	
search = AMapSearchAPI()
search?.delegate = self
}
    
// 逆地理编码
func reverseGeocoding(){
	
let coordinate = currentLocation?.coordinate
	
// 构造 AMapReGeocodeSearchRequest 对象，配置查询参数（中心点坐标）
let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
	
regeo.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate!.latitude), longitude: CGFloat(coordinate!.longitude))
	
	
	
// 进行逆地理编码查询
self.search!.AMapReGoecodeSearch(regeo)
	
}

// 定位回调
func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
if updatingLocation {
    currentLocation = userLocation.location
}
}
	
// 点击Annoation回调
func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
// 若点击的是定位标注，则执行逆地理编码
if view.annotation.isKindOfClass(MAUserLocation){
    reverseGeocoding()
}
}
	
// 逆地理编码回调
func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
	
	
if (response.regeocode != nil) {
	
var title = response.regeocode.addressComponent.city
title = response.regeocode.addressComponent.province
	
//给定位标注的title和subtitle赋值，在气泡中显示定位点的地址信息
mapView?.userLocation.title = title
mapView?.userLocation.subtitle = response.regeocode.formattedAddress
	
}
	
}
}

```
