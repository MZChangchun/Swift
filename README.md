# 鼎永科技转正笔试题

# 1.填空题
1.对象的属性特性包含___`多线程特性、读写特性和内存管理特性`__。
2.任何一个应用都有且只有一个__`UIWindow`__对象包含应用中的所有视图。
3.视图绘制到屏幕上的过程是_`每个视图分别绘制自己（包括UIWindow对象`）___和__`将所有视图的图层组合成一幅图像绘制到屏幕上`__。
4.`UIView`的上级父类是__`UIResponder`__，所以表明他有可视和和__可交互_。
5.`Objective-C`对象都有一个名为__`isa`_____的实例变量，通过它知道自身的类型。
6.当NIB文件被载入后，其中的插座变量是通过___`键值编码（KVC）`___来设置的。
7.__`UIImage、UIBezierPath和NSString`___都提供了至少一种用于在drawRect:中绘图的方法以便分别将图像、图形和文本绘制到视图的图层上。这些都是由___`Core Graphics`___框架完成的。
8.UILabel根据显示的文字调整大小的方法是__`sizeToFit`_。
9.如何让UISearchBar支持空搜索____`searchController.searchBar.enablesReturnKeyAutomatically = NO;`____
10.测试或实施拿来你的app告诉你说你的某个web里面的某个功能无法使用，而安卓和Chrome都是正常的，这时你应该_`根据经验，如果有之前解决过的还按那个方法解决，否则首先要获取这个有问题的页面的url,在Safari中打开这个URL看是否有同样的问题，然后联合相应的web人员查看页面的源码找到问题的原因，然后 翻墙Google解决办法`_____
# 2.判断题（判断对错，错误的说出原因。正确的请举例说明）
1.UIGestureRecognizer对象会截取本应由视图处理的触摸事件，所以可以用它直接为应用添加手势识别功能。
`错误，UIGestureRecognizer不能直接给应用添加手势识别，需要使用他的子类。`
2.类扩展中可以声明类的内部属性和方法。
`正确，注意区分类扩展extension和分类category的区别。`

3.NSUserDefaults的 setObject:forKey:方法会将对象存储到plist文件中，可以存储的类型包括:NSArray、NSDictionary、NSString、NSData、NSObject 和 NSNumber类型。
`错误，plist文件不能直接存储NSObject类型的对象，需要归档后存储。`

4.Storyboard文件就是XIB文件。
`错误，Storyboard文件不仅能够构建界面，还可以为多个视图控制器设置相互之间的关系。`

5.当某个对象有一个指向其他对象的实例变量时，可以说该对象拥有该实例变量自身。
`错误，是拥有该实例变量所指向的对象。即指针指向另外一个指针指向的地址而不是该指针的地址。`



# 3.问答题


## 1.WKWebView是什么？是如何和原生应用交互的
`iOS8`以后，苹果推出了新的框架` webkit`，这个框架里带来了新的能够替代`UIWebView`的组件`WKWebView`，此控件相对于`UIWebView`来说，速度更快了，占用内存少了，在性能稳定性和功能上有很大的提升；允许`JavaScript`的`Nitro`库加载并使用，高达60fps的滚动刷新率和内置手势。
### a.动态加载并运行JS：
通过`WKWebView `的 `WKWebViewConfiguration `的 `userContentController`属性的`addUserScript`方法 加载 `WKUserScript `类型的js代码例如：
```
NSString *js = @"var count = document.images.length;
for (var i = 0; i < count; i++) {
var image=document.images[i];
image.style.width=320;
};
window.alert('找到' + count + '张图');";
WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init]; 
[config.userContentController addUserScript:script]; 
_webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config]; 
[_webView loadHTMLString:@"<head></head><imgea src='http://www.nsu.edu.cn/v/2014v3/img/background/3.jpg' />"baseURL:nil]; 
[self.view addSubview:_webView];
```
### b.直接掉用`WKWebView `的`evaluateJavaScript`方法
```[webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];```

### c.web端掉用app
首先，设置```WKScriptMessageHandler```代理 注册JS名
```[_configuretion.userContentController addScriptMessageHandler:self name:@"setTitle"];```
在代理方法中判断和获取JS的详细信息
```
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"setTitle"]) {//设置标题
        self.title = message.body;
    }
}
```
## 2.谈谈你所理解的内存区域？
### a.栈区(stack)
向低地址扩展的数据结构，是一块连续的内存区域，由编译器自动分配并释放，存放函数的参数值，局部变量等。栈是系统数据结构，对应线程/进程是唯一的。优点是快速高效，缺点时有限制，数据不灵活。［先进后出］
栈空间分静态分配 和动态分配两种。
静态分配是由编译器完成的，比如自动变量（auto）的分配；
动态分配是由alloca函数完成的。
栈的动态分配无需释放，也没有释放函数
### b.堆区(heap) 
向高地址扩展的数据结构，是不连续的内存区域，（链表结构，遍历方向是由低地址向高地址）由程序员分配和释放，如果程序员不释放，程序结束时，可能会由操作系统回收 ，比如在ios 中 alloc 都是存放在堆中。
优点是灵活方便，数据适应面广泛，但是效率有一定降低。
堆是函数库内部数据结构，不一定唯一
不同堆分配的内存无法互相操作
堆空间的分配是动态的
虽然程序结束时所有的数据空间都会被释放回系统，但是精确的申请内存，释放内存匹配是良好程序的基本要素。
### c.全局区(静态区) (static)
全局变量和静态变量的存储是放在一起的，初始化的全局变量和静态变量存放在一块区域，未初始化的全局变量和静态变量在相邻的另一块区域，程序结束后有系统释放。
可分为未初始化全局区、bss段、初始化全局区和data段
### d.文字常量区 存放常量字符串，程序结束后由系统释放；
### e.代码区 存放函数的二进制代码
代码示例
```
int a = 10;//全局初始化区
char *p;//全局未初始化区
main {
int b;// 栈区
char s[];// 栈
char * p1;// 栈
char * p2 = "123456";// 123456在常量区 p2在栈（指针）
static int c = 10;// 全局静态初始化区

//分配得来的10 和 20 个字节的区域在堆区
w1 = (char *)malloc(10);
w2 = (char *)malloc(20)
}
```
## 3.并发、并行、串行、同步、异步的理解？
### a.并发：
在操作系统中，是指一个时间段中有几个程序都处于已启动运行到运行完毕之间（单核时间片轮转），且这几个程序都是在同一个处理机上运行。（异步线程实现的一种形式）。
当有多个线程在操作时,如果系统只有一个CPU,则它根本不可能真正同时进行一个以上的线程，它只能把CPU运行时间划分成若干个时间段,再将时间 段分配给各个线程执行，在一个时间段的线程代码运行时，其它线程处于挂起状（微观上是顺序执行）。
### b.并行：
在多处理器系统中，一组程序按独立异步的速度执行，不等于时间上的重叠（同一个时刻发生)。（异步线程实现的一种形式）
并发不一定并行，并行一定并发。
### c.串行：
就是任务A执行结束才能开始执行B，单个线程只能执行一个任务，就如单行道只能行驶一辆车。（同步线程的实现方式）
### d.同步：
多个任务情况下，一个任务A执行结束，才可以执行另一个任务B。只存在一个线程。进程之间的关系不是相互排斥临界资源的关系，而是相互依赖的关系。进一步的说明：就是前一个进程的输出作为后一个进程的输入，当第一个进程没有输出时第二个进程必须等待。具有同步关系的一组并发进程相互发送的信息称为消息或事件。
### e.异步：
多个任务情况下，一个任务A正在执行，同时可以执行另一个任务B。任务B不用等待任务A结束才执行。存在多条线程。

## 4.多线程的理解
### a.进程：
可以理解成一个运行中的应用程序，是系统进行资源分配和调度的基本单位，是操作系统结构的基础，主要管理资源。
### b.线程：
是进程的基本执行单元，一个进程对应多个线程。
### c.主线程：
处理UI，所有更新UI的操作都必须在主线程上执行。不要把耗时操作放在主线程，会卡界面。
### d.多线程：
在同一时刻，一个CPU只能处理1条线程，但CPU可以在多条线程之间快速的切换，只要切换的足够快，就造成了多线程一同执行的假象。
多线程是通过提高资源使用率来提高系统总体的效率。
我们运用多线程的目的是：将耗时的操作放在后台执行！
### e.
生命周期:新建 - 就绪 - 运行 - 阻塞 - 死亡
### f.任务：
即操作，你想要干什么，说白了就是一段代码。任务有两种执行方式： 同步执行 和 异步执行，主要区别在于会不会阻塞当前线程
### g.队列：
用于存放任务。一共有两种队列， 串行队列 和 并行队列。放到串行队列的任务，GCD 会 FIFO（先进先出） 地取出来一个，执行一个，然后取下一个，这样一个一个的执行。放到并行队列的任务，GCD 也会 FIFO的取出来，但不同的是，它取出来一个就会放到别的线程，然后再取出来一个又放到另一个的线程。这样由于取的动作很快，忽略不计，看起来，所有的任务都是一起执行的。不过需要注意，GCD 会根据系统资源控制并行的数量，如果任务很多，它并不会让所有任务同时执行。
### 实现方式：
`pthread、NSThread、NSOperation和GCD`。

## 5.属性的特性
### a.多线程特性：
nonatomic（非原子属性，同一时间可以有很多线程读和写，非线程安全，效率高。非默认）
atomic（原子属性，线程安全，保证同一时间只有一个线程能够写入，但是同一时间多个线程都可以读取，需要消耗大量资源）
### b.读写特性：
readwrite(默认，编译器会生成存方法set和取方法get)
readonly（编译器只会生成存取方法get）
### c.内存管理特性：
strong（对象属性默认值，强引用）
weak（弱引用，可避免强引用循环）
copy （可变对象应该设置为copy，先复制该对象，再将属性指向复制后的对象。想不可变对象发送copy消息时，会返回一个指向自己的指针）
unsafe_unretained（非对象属性默认值，不指向任何对象的属性，表示存取方法会直接为实例变量赋值，引入ARC之前使用assign表示。可以指向object-c的对象，但是被销毁时指针不会自动设置为nil，而是成为空指针，因此不安全，但是处理非对象属性时不会出现空指针问题）.


## 6.NSMutableArray的removeObject:方法和removeObjectIdenticalTo:方法的区别是什么?
removeObject:方法会枚举数组，向每一个对象发送isEqual:消息。isEqual:的作用是判断当前对象和传入对象所包含的数据是否相等。不同的类可以根据自身情况覆盖isEqual:并实现相应的逻辑。
removeObjectIdenticalTo:方法不会比较对象所包含的数据，只会比较指向对象的指针。该方法只会移除数组所保存的那些和传入对象指针完全相同的指针。


## 7.看代码是否有问题，有问题的话是什么原因？该如何修改？
```
@property (nonatomic, strong) NSString *target;
//....
dispatch_queue_t queue = dispatch_queue_create("parallel", DISPATCH_QUEUE_CONCURRENT);
for (int i = 0; i < 1000000 ; i++) {
dispatch_async(queue, ^{
self.target = [NSString stringWithFormat:@"ksddkjalkjd%d",i];
});
}
```

自定义的队列,运行崩溃.这个对象是Strong修饰的
他的Setter方法在MRC上就相当于
```
- (void)setTarget:(NSString *)target {
[target retain];//先保留新值
[_target release];//再释放旧值
_target = target;//再进行赋值
}
```
这是个并行队列+异步
假如队列A执行到步奏2，还没到步骤3时，队列B也执行到步骤2，那么这个对象就会被过度释放，导致向已释放内存对象发送消息而崩溃。
1.使用串行队列
将set方法改成在串行队列中执行就行，这样即使异步，但所有block操作追加在队列最后依次执行。
2. 使用atomic
atomic关键字相当于在setter方法加锁，这样每次执行setter都是线程安全的，但这只是单独针对setter方法而言的狭义的线程安全。
3.使用weak关键字
weak的setter没有保留新值或者保留旧值的操作，所以不会引发重复释放。当然这个时候要看具体情况能否使用weak，可能值并不是所需要的值。
4.使用Tagged Pointer
Tagged Pointer是苹果在64位系统引入的内存技术。简单来说就是对于NSString（内存小于60位的字符串）或NSNumber（小于2^31），64位的指针有8个字节，完全可以直接用这个空间来直接表示值，这样的话其实会将NSString和NSNumber对象由一个指针转换成一个值类型，而值类型的setter和getter又是原子的，从而线程安全。

线程安全有以下几种方法：
* 单线程串行访问
* 访问加锁
* 使用不进行额外操作的关键字（weak）
* 使用值类型
