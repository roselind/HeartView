---
title: Swift中的Realm使用
date: 2016-04-20 
---
关于Realm，你要知道下面几点：
1.使用简单，大部分常用的功能（比如插入、查询等）都可以用一行简单的代码轻松完成，学习成本低。
2.Realm不是基于Core Data，也不是基于SQLite封装构建的。它有自己的数据库存储引擎。
3.Realm具有良好的跨平台特性，可以在iOS和Android平台上共同使用。代码可以使用 Swift 、 Objective-C 以及 Java 语言来编写。
<!--more-->
---


### 安装
用Cocoapods导入Realm框架
首先在XCode中安装插件RealmPlugin/mac软件RealmBrowser
再新建新文件Realm ModelObject



### 创建模型类
		这是一个模型类
		import Foundation
		import RealmSwift

		class Status: Object {
    

    dynamic var StatusID:Int?
    
    dynamic var text:String?
    
    
    
		}
		
### 创建一个一对多的模型类

			class User: Object {
    

    
    dynamic var name : String!
    dynamic var createTime: String!
    
    let StatusList = List<Status>()
    
    
		}
			1.List 用来表示一对多的关系：一个 StatusList 中拥有多个 Status。
		2.List 和 Array 在使用上非常相似，所用的方法和访问数据的方式（索引和下标）都相同。正如你所见的一样，List 后标明了数据类型，所包含的所有对象都应该是相同类型的。
		3.List 是泛型，这也是为什么我们没有在声明前面加上 dynamic 的原因，因为在 Objective-C 运行时无法表示泛型属性。




### 数据库插入操作

				注意在AppDelegate中创建数据库对象，就可以全局调用了
		       let realm = try! Realm()
       
        //判断数据库是否是空的
        if realm.objects(Status).count > 0
        {
          return
        
        let item1 = Status()
        item1.StatusID = 111
        item1.text = "这是一条test"
        
        let item2 = Status(value: [222,"这是第二条test"])
        
        
        try! realm.write({ 
            realm.add(item1)
            realm.add(item2)
        })
        
        
        print(realm.path)

### 读取数据库

			定义一个结果集
			 var statusItems: Results<Status>!

			 let realm = try! Realm()
        statusItems = realm.objects(Status)
###  删除数据

		比如删除一条ID是111的数据
       let statusItem = realm.objects(Status).filter("StatusID = '111' ")
       try! realm.write {
            realm.delete(statusItem)
        }
### 删除全部
		
       try! realm.write {
            realm.deleteAll()
        }
### 更新数据
#### 直接更新

		realm.write {
		  statusItems.text = "我更新了数据"
		}
#### 通过主键更新
		如果数据模型中设置了主键的话，那么可以使用Realm().add(_:update:)来更新对象（当对象不存在时也会自动插入新的对象。）
		第一种方法
		// 假设我们把StatusID设置为主键
		realm.write {
		  realm.add(StatusID, update: true)
		}

		第二种方法
		realm.write {
		  realm.create(Status.self, value: ["StatusID": 1, "text": "test"], update: true)
		// 注意此处没有改变值的对象的值将不会更新
		}
#### 通过KVC更新
		这个是在运行时才能决定哪个属性需要更新的时候，这个对于大量更新的对象极为有用。

		   let status = realm.objects(Status)

       try! realm.write {
        
           status.setValue("更新", forKey: "text")
        }
  

### 断言查询数据库

		 statusItems = realm.objects(Status).filter("StatusID  > 111 ")

			支持链式查询
			statusItems = self.realm.objects(Status).filter("StatusID > 111 ").filter("text = '这是第二条test'")

### 对查询结果进行排序

			//查询ID超过111的内容,并按升序排列
		statusItems = self.realm.objects(Status).filter("StatusID > 111").sorted("StatusID")

### 添加主键(Primary Keys) 
 
声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。

			class Status: Object {
    

    dynamic var StatusID:Int?
    
    dynamic var text:String?
    
    
		      override static func primaryKey() -> Int? {
    return "StatusID"
		  }
    
		}

### 添加索引属性(Indexed Properties)
		 override static func indexedProperties() -> [String] {
    return ["text"]
		  }

### 设置忽略属性(Ignored Properties)
		  override static func ignoredProperties() -> [String] {
    return ["text"]
		  }






