---
title: Swift中FMDB的使用
date: 2016-05-04 10:11:43
---

今天介绍下iOS中的老牌数据库框架FMDB在Swift中的使用以及常用的SQL语句

<!--more-->

在Swift中建议使用单例创建工具类的方法

```swift
class SQLiteManager: NSObject {
    
    
private static let manager: SQLiteManager = SQLiteManager()
/// 单例
class func shareManager() -> SQLiteManager {
return manager
}
    
var dbqueue:FMDatabaseQueue?
```


# 建表
在工具类中实现创建并打开数据库的方法

1.创建表

```
private func createStatusTable()
{
// 1.编写SQL语句 数据库名大写 前面加T_
let sql =  "CREATE TABLE IF NOT EXISTS T_Status( \n" +
"statusId INTEGER PRIMARY KEY, \n" +
"statusText TEXT, \n" +
"userId INTEGER \n" +
"); \n"

//建表 在sqlite中除了查询都是update
dbqueue!.inDatabase { (db) -> Void in
db.executeUpdate(sql, withArgumentsInArray: nil)
}
}
```

2.打开表

```swift
func openDB(DBName:String)
{
//根据传入的数据库名字拼接数据库路径
let path = DBName.docDir()
print(path)
//创建数据库对象
dbqueue = FMDatabaseQueue(path: path)
//打开数据库
  
//创建微博表
createStatusTable()
//创建信息表
    
}
```


3.在AppDelegate中调用方法

```
// 打开数据库
    SQLiteManager.shareManager().openDB("status.sqlite")
```

到此为止建表操作已经结束

# 插入数据

在iOS开发中我们通常获取网络数据，并插入到数据库中
在网络请求之后将JSON数据插入数据库的过程：
tips:让本地和网络返回的数据类型保持一致, 以便于后期处理

```swift
/// 缓存微博数据
class func cacheStatuses(statuses: [[String: AnyObject]])
{
    
// 0. 准备数据
let userId = userAccount.loadAccount()!.uid!
    
// 1.定义SQL语句
let sql = "INSERT INTO T_Status" +
"(statusId, statusText, userId)" +
"VALUES" +
"(?, ?, ?);"
    
// 2.执行SQL语句
SQLiteManager.shareManager().dbqueue?.inTransaction({ (db, rollback) -> Void in
    
for dict in statuses
{
let statusId = dict["id"]!
// JSON -> 二进制 -> 字符串
let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
let statusText = String(data: data, encoding: NSUTF8StringEncoding)!
// print(statusText)
if !db.executeUpdate(sql, statusId, statusText, userId)
{
// 如果插入数据失败, 就回滚
rollback.memory = true
    }
    
    }
})
}
```


# 读取数据

```swift
class func loadCacheStatuses(since_id: Int, max_id: Int, finished: ([[String: AnyObject]])->()) {

// 1.定义SQL语句

let sql = "SELECT * FROM T_message \n" + "WHERE type= '\(type)' \n" + "ORDER BY messageId DESC \n"

// 2.执行SQL语句
SQLiteManager.shareManager().dbqueue?.inDatabase({ (db) -> Void in

// 2.1查询数据
let res =  db.executeQuery(sql, withArgumentsInArray: nil)

// 2.2遍历取出查询到的数据
// 返回字典数组的原因:通过网络获取返回的也是字典数组,
// 让本地和网络返回的数据类型保持一致, 以便于后期处理
var statuses = [[String: AnyObject]]()
while res.next()
{
// 1.取出数据库存储的一条微博字符串
let dictStr = res.stringForColumn("statusText") as String
// 2.将微博字符串转换为微博字典
let data = dictStr.dataUsingEncoding(NSUTF8StringEncoding)!
let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
statuses.append(dict)
}

// 3.返回数据
finished(statuses)
})
}
```  

# 网络请求逻辑

```
// 1.从本地数据库中获取
loadCacheStatuses(since_id, max_id: max_id) { (array) -> () in
if !array.isEmpty
{
print("从数据库中获取")
finished(array, error: nil)
return
}
//从网络获取 并调用缓存方法
}
```

# SQL语法

## 创建表

```sql
CREATE TABLE IF NOT EXISTS "T_Person" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"name" TEXT,
"age" INTEGER,
"heigth" REAL
)
//下边是sqllite编译器里边的语句

/*简单约束*/
CREATE TABLE IF NOT EXISTS t_student
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
age INTEGER
);

CREATE TABLE IF NOT EXISTS t_student
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT UNIQUE,
age INTEGER
);

/*添加主键*/
CREATE TABLE IF NOT EXISTS t_student
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
age INTEGER,
score REAL
);

/*添加主键*/
CREATE TABLE IF NOT EXISTS t_student
(
id INTEGER,
name TEXT,
age INTEGER,
score REAL,
PRIMARY KEY(id)
);
```

## 查询

```sql
/*分页*/
SELECT * FROM t_student
ORDER BY id ASC LIMIT 30, 10;

/*排序*/
SELECT * FROM t_student
WHERE score > 50
ORDER BY age DESC;

SELECT * FROM t_student
WHERE score < 50
ORDER BY age ASC , score DESC;

/*计量*/
SELECT COUNT(*)
FROM t_student
WHERE age > 50;

/*别名*/
SELECT name as myName, age as myAge, score as myScore
FROM t_student;

SELECT name myName, age myAge, score myScore
FROM t_student;

SELECT s.name myName, s.age myAge, s.score myScore
FROM t_student s
WHERE s.age > 50;

/*查询*/
SELECT name, age, score FROM t_student;
SELECT * FROM t_student;
```


## 修改

```sql
UPDATE t_student
SET name = 'MM'
WHERE age = 10;

UPDATE t_student
SET name = 'WW'
WHERE age is 7;

UPDATE t_student
SET name = 'XXOO'
WHERE age < 20;

UPDATE t_student
SET name = 'NNMM'
WHERE age < 50 and score > 10;

/*更新记录的name*/
UPDATE t_student SET name = 'zhangsan';
```


## 删除

```sql
DELETE FROM t_student;

DELETE FROM t_student WHERE age < 50;

/*删除表*/
DROP TABLE IF EXISTS t_student;
```
 
## 插入

```sql
INSERT INTO t_student
(age, score, name)
VALUES
('28', 100, 'zhangsan');

INSERT INTO t_student
(name, age)
VALUES
('lisi', '28');

INSERT INTO t_student
(score)
VALUES
(100);
```