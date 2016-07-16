---
title: ReactiveCocoa
date: 2016-05-14 23:52:29

---

最近在学 慢慢整理
<!--more-->
## 代替代理
```
  //代替代理
    [[_bgView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击了btn");
    }];
```
## 代替KVO
```
//第一种写法
[RACObserve(scrolView, contentOffset) subscribeNext:^(id x) {
    NSLog(@"滚动");
}];
//第二种写法
    [[_bgView rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"发生改变%@",x);
    }];
```

## 代替通知
通知不需要remove

```
//监听事件
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"弹出键盘");
    }];
```


## 代替输入事件
```
 //监听文本框文字改变
    [_textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"改变如下%@",x);
    }];
 //可以对其筛选
[_textField.rac_textSignal filter:^BOOL(NSString *value) {
        return value.length > 3;
    }];
```

## map

这里的map是映射的意思，就是创建一个订阅者的映射并且返回数据，具体用法我们来看代码。

```objc
[[self.textFild.rac_textSignal map:^id(id value) {
    NSLog(@"%@", value);
    return @1;
}] subscribeNext:^(id x) {
    NSLog(@"%@", x);
}];
//打印值为
2016-01-05 15:02:15.180 RACStudyTest[1418:57245] 1
2016-01-05 15:02:21.710 RACStudyTest[1418:57245] g
2016-01-05 15:02:21.711 RACStudyTest[1418:57245] 1
2016-01-05 15:02:22.954 RACStudyTest[1418:57245] go
2016-01-05 15:02:22.955 RACStudyTest[1418:57245] 1
2016-01-05 15:02:23.464 RACStudyTest[1418:57245] goo
2016-01-05 15:02:23.464 RACStudyTest[1418:57245] 1
2016-01-05 15:02:23.705 RACStudyTest[1418:57245] good
2016-01-05 15:02:23.705 RACStudyTest[1418:57245] 1
```

当监听的对象发生改变时map会返回设定的值


## take/skip/repeat/delay/throttle/distinctUntilChanged/timeout/ignore关键字

take:获取 只操作前NSInteger个操作

skip:跳过前NSInteger个操作

repeat:重复发送信号

delay:延迟操作 秒单位

throttle:节流操作 秒单位 秒单位内发生变化不操作

distinctUntilChanged:只调用一次

timeout: onScheduler:超时发送error

igone:忽略信号，指定一个任意类型的量（可以是字符串，数组等），当需要发送信号时讲进行判断，若相同则该信号会被忽略发送

```objc
RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendNext:@"1"];
    [subscriber sendNext:@"2"];
    [subscriber sendNext:@"3"];
    [subscriber sendNext:@"4"];
    [subscriber sendNext:@"5"];
    [subscriber sendCompleted];
    return nil;
}] take:2];

[signal subscribeNext:^(id x) {
    NSLog(@"%@", x);
}completed:^{
    NSLog(@"completed");
}];
```

相似的还有takeLast takeUntil takeWhileBlock skipWhileBlock skipUntilBlock repeatWhileBlock都可以根据字面意思来理解
