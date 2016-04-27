---
title: ReactiveCocoa官方文档-自翻
date: 2016-04-19 
---


github官方文档,rac很火,看看顺便翻译一下


<!--more-->

---


# ReactiveCocoa（RAC）是一个基于Cocoa框架的函数响应式编程技术，它提供了一种如何将标准的动作与事件处理逻辑替换为发送事件流的信号的接口。
-	介绍-	例子：在线搜索-	Objective-C和Swift-	ReacitveCocoa与Rx的关联-	入门
如果你对于函数响应式编程或者什么是ReactiveCocoa已经比较熟悉，你可以查看我们的文件夹，以了解更多关于它的工作方式的详细信息。然后直接进入我们的文档，以了解更多关于细节的说明。

如果您有疑问，请查看GitHub（一个知名的开源项目社区）中的讨论或者Stack overFlow（一个知名的IT问题交流社区）是否已经有相关的答案了，如果没有，您可以免费的向我们提问。# 兼容性
   文档中说明RAC4已经支持到了Swift 2.1.x，关于Swift 1.2的文档支持说明都在RAC3文件夹中。非常感谢Rheinfabrik对于RAC 3发展上的慷慨赞助。# 介绍  RAC的灵感来源于函数响应式编程，RAC提供了一种“事件流”来代替了随便可以百变的可变变量，它通过信号和信号生产者这两个类型来表示，它们随着时间的推移发送一个值。事件流中包含了所有的对异步和事件的处理，其中包括了一下常见的模式： 
- 委托方法
- 回调- 通知- 控制动作和响应链事件- 并发编程- 键值观察因为以上的所有这些不同的机制可以以同样的方式来代表，所以我们很简单的用链式编程以声明方式链将它们结合在一起。有关RAC概念的更多信息，请参见我们的框架概述。
# 例子：在线搜索比方说，你有一个文本字段，用户键入内容，你想要使用网络请求搜索查询。
观察文本编辑



	let searchStrings = textField.rac_textSignal()
	.toSignalProducer()
	.map { text in text as! String }

  第一步是观察编辑文本字段，RAC中扩展的UITextField专门为此而使用,这给了我们一个能够发送字符串类型的信号生产者。## 发送网络请求  获得了这个字符串之后，我们想要发送一个网络请求，幸运的是，RAC同样提供了一个NSURLSession扩展来实现：
  


	let searchResults = searchStrings
	.flatMap(.Latest) { (query: String) -> SignalProducer<(NSData, NSURLResponse), NSError> in
	let URLRequest = self.searchRequestWithEscapedQuery(query)
	return NSURLSession.sharedSession().rac_dataWithRequest(URLRequest)
	}
	.map { (data, URLResponse) -> String in
	let string = String(data: data, encoding: NSUTF8StringEncoding)!
	return self.parseJSONResultsFromString(string)
	}
	.observeOn(UIScheduler())


这个过程将会把我们发送的字符串得到的搜索结果转换成接受到的数组，它将在主线程中被执行（得益于主线程调度）。
  
另外，flatMap是确保最后的唯一一个搜索被执行的关键。如果用户在搜索中改变了输入字符，它会在取消之前再创建一个新的搜索，想象一下如果我们正常的写这些代码需要多大的工程吧！## 接受结果上述代码实际上还并没有被执行，因为生产者必须点击开始以获得结果（当结果不需要获得时可以避免运作），这是非常容易实现的：


	
	searchResults.startWithNext { results in
	print("Search results: \(results)")
	}


在这里，我们需要观察Next这个事件，它包含我们的结果，并将它们输出到控制台，在这个期间我们可以更新一个表视图或者在屏幕上更新一个控件。
## 错误处理
为了解决这个问题，我们需要知道是哪个步骤出了问题。最快的解决方法是在控制台打印它们，然后解决它们。通过这个方法，我们可以有效的解决它们。但是，我们在解决之前可能会重试至少几次。方便的是，有一个重试关键字就是用来方便我们操作的。我们改进过的搜索结果大概看起来是这个样子的：


	.flatMap(.Latest) { (query: String) -> SignalProducer<(NSData, NSURLResponse), NSError> in
	let URLRequest = self.searchRequestWithEscapedQuery(query)
		
	return NSURLSession.sharedSession()
	.rac_dataWithRequest(URLRequest)
	.flatMapError { error in
	print("Network error occurred: \(error)")
	return SignalProducer.empty
	}
	}
## 节流请求
现在，我们假设你想要在只有用户停止输入的时候才发送搜索请求以节省流量。 
RAC声明了一个节流阀关键字，我们通过它来实现这个操作。

	let searchStrings = textField.rac_textSignal().toSignalProducer().map {
		text in text as! String 
		}.throttle(0.5, onScheduler: QueueScheduler.mainQueueScheduler)

这样可以防止值被发送不到0.5秒的情况下再次发送，所以我们会搜索用户输入的字符串直到用户停止编辑。如果要通过正常的写代码做到这个，代码将会变得难以阅读！在RAC中，我们在事件流之中只需要使用一个时间关键字。# Objective-C和Swift 虽然RAC是基于Objective-C的一个框架，我们称之为3.0版本，现在所有主要功能的开发主要集中在swift的API接口中。RAC的Objective-C API接口和Swift API接口是完全分开的，但通过一个桥接文件可以转换。这主要用于一个老版本的使用了RAC项目或者还没有改变到Swift的项目。Objective-C的API接口将会继续存在，在可预见的将来也会继续得到技术支持，但不会得到很多的改进，有关使用此API的更多信息，请查看我们的官方文档。我们强烈建议所有的新项目使用Swift API。
# 关于ReactiveCocoa和Rx的关联？  RAC的灵感，影响于微软的Rx库。Rx有很多接口，包括RxSwift，不过RAC不直接提供接口。## RAC和Rx的不同点在于：- RAC创建了一个更简单的API接口
 
- RAC解决了令人困惑的常见问题
  
- RAC更加适配Cocoa
  
- 下文就会说明他们中的一些具体的差异。
## 命名  在大多数Rx的版本中，流通常被称为观察者，也就是.NET中的枚举类型。另外的，大多数Rx.net的操作符命名规则来源于LINQ，使用了类似数据库里的关键字Select和Where等。RAC关注于适配Swift中的命名规则，新增了新的术语类似map、filter。其他新的命名来源于Haskell和Elm语言（信号一词的来源）。## 信号和信号产生者（“热”和“冷”观察形态）  Rx中让人困惑的最多的问题之一就是“热”，“冷”，“温”的观察形态。
  
简短来说，我们可以通过C#中的一个方法或者函数来形容它：告诉订阅（观察者），iobservable将涉及的副作用是非常重要的。如果它会产生副作用，也不可能不回家告诉每个订阅它是否有副作用，或是否只有第一个订阅者会产生副作用。
  
虽然这个例子是人为造成的，但是它展示了一个真实的普遍的问题，它会使得代码变得非常难以一目了然的来解决问题。RAC 3.0 已经通过使用信号和信号生产者类型区别副作用来独立的解决了这个问题，虽然因为这样我们需要多了解另外一个类型，但是它提高了代码的清晰度，并有助于传达意图。换句话说，RAC的改变虽然简单，但是并不容易。类型错误  当信号和信号制造者在RAC中产生错误时，系统必须给出一个错误类型。举个例子，Signal<Int，NSError>会传一个带有错误值的NSError类型。更重要的是，RAC中的特殊类型NOERROR可以保证一个事件流不允许发送失败，这消除了很多由于意外产生的错误。在Rx系统的类型中，事件流只能只能观察它们的值，而不能观察错误的值，所以在Rx中这是不能实现的。## UI编程  很多人不知道怎么使用Rx，虽然使用Rx在UI编程是很常见的，它有几个特点，针对特定的情况下。RAC在ReactiveUI中获得了许多的灵感，包括灵感的基础。不像ReactiveUI，不幸的是不能在UI编程中使得Rx使用起来更加友好，ReactiveCocoa已专门为此多次改进，这意味着我们跟Rx的不同之处也越来越多。# 入门  RAC支持OS X 10.9+,iOS 8.0+， watchOS 2.0，和tvOS 9.0。在你的应用中添加RAC。
- 添加RAC作为子模块到你的应用程序中。- 在RAC文件夹中运行脚本- 将RAC的工程文件或者Carthage/Checkouts/Result工程文件添加到你的应用程序的工程或者工作空间。- 在你的应用程序的设置中的“常规”选项卡中，添加ReactiveCocoa.framework和Result.Framework库。- 如果你的应用程序中不存在任何Swift代码，你应该设置EMBEDDED_CONTENT_CONTAINS-SWIFT为yes。 
-  或者如果你使用Carthage的话，那就更简单了，添加到你的Cartfile：github “ReactiveCocoa/ReactiveCocoa”。确保在”Linked Frameworks”和”copy frameworks”选项中添加了ReactiveCocoa和Result.framework.。如果你更喜欢用CocoaPods，还有一些慷慨贡献的第三方podspecs。当你设置你的工程的时候，看看RAC框架概念的概述，并研究一下我们官方给出的使用例子。