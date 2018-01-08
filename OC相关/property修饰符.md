# 1.UIView用assign还是用retain？
* 1.xib 或SB拖出来的用assign，因为xib它们已经持有了这个view
* 2.自己定义的view 用retain，有人说用assign也可以。确实用assign也可以，但是要注意以下情况


```
1.用assign的好处就是removeFromSuperview 以后这个view会自动dealloc
2.但是！但是！但是！ 这个view dealloc以后指向这个view的指针并不会自动设置为nil，也就是说这个时候指向这个view的指针是野指针，你再直接用的时候就崩溃！
```
下面就是访问野指针崩溃的例子：

```
声明变量：
@property(nonatomic, assign)TKTradeFirstFloorLoginedView *loginedView; // 已经登录的页面
@property(nonatomic, assign)TKTradeFirstFloorUnloginView *unloginView; // 未登录页面
```

使用：

```
if (accountInfo) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.unloginView removeFromSuperview];
            NSLog(@"+++++++++4333++++++loginedView:%@", _loginedView);
            NSLog(@"%p", _loginedView);
            [self.view addSubview:self.loginedView];
            
            [self updateAccountInfo:accountInfo];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
             NSLog(@"+++++++++11++++++loginedView:%@", _loginedView);
            [self.loginedView removeFromSuperview];
            
            NSLog(@"+++++++22++++++++loginedView:%@", _loginedView);
            [self.view addSubview:self.unloginView];
        }];
    }
```

输出:

```
崩溃：
2017-06-15 15:29:04.510 TKTrade[49357:1295008] +++++++++11++++++loginedView:(null)
2017-06-15 15:29:04.517 TKTrade[49357:1295008] +++++++22++++++++loginedView:<TKTradeFirstFloorLoginedView: 0x7f884ed0a6d0; frame = (0 0; 375 667); autoresize = W+H; animations = { position=<CABasicAnimation: 0x600000224b00>; bounds.origin=<CABasicAnimation: 0x600000226380>; bounds.size=<CABasicAnimation: 0x600000226340>; }; layer = <CALayer: 0x60800042a040>>
2017-06-15 15:29:04.552 TKTrade[49357:1295008] ++++++++++++++++++++TKTradeFirstFloorLoginedView dealloc
2017-06-15 15:29:16.810 TKTrade[49357:1295008] +++++++++4333++++++loginedView:The user name or password you entered for the %@ proxy server %@ was incorrect. Make sure you’re entering them correctly, and then try again.
2017-06-15 15:29:16.810 TKTrade[49357:1295008] `0x7f884ed0a6d0(这个值就是野指针了！！！！)`
2017-06-15 15:29:16.810 TKTrade[49357:1295008] -[__NSCFString superview]: unrecognized selector sent to instance 0x7f884ed0a6d0
2017-06-15 15:29:16.845 TKTrade[49357:1295008] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFString superview]: unrecognized selector sent to instance 0x7f884ed0a6d0'
*** First throw call stack:
(
	0   CoreFoundation                      0x0000000111fbbb0b __exceptionPreprocess + 171
	1   libobjc.A.dylib                     0x0000000110e49141 objc_exception_throw + 48
	2   CoreFoundation                      0x000000011202b134 -[NSObject(NSObject) doesNotRecognizeSelector:] + 132
	3   CoreFoundation                      0x0000000111f42840 ___forwarding___ + 1024
	4   CoreFoundation                      0x0000000111f423b8 _CF_forwarding_prep_0 + 120
	5   UIKit                               0x000000010de56fc1 -[UIView(Internal) _addSubview:positioned:relativeTo:] + 142
	6   UIKit                               0x000000010de459a8 -[UIView(Hierarchy) addSubview:] + 838
	7   TKTrade                             0x000000010b4260f8 __59-[TKTradeFirstFloorViewController updateViewByAccountInfo:]_block_invoke + 248
	8   UIKit                               0x000000010de5108a +[UIView(UIViewAnimationWithBlocks) _setupAnimationWithDuration:delay:view:options:factory:animations:start:animationStateGenerator:completion:] + 572
	9   UIKit                               0x000000010de51643 +[UIView(UIViewAnimationWithBlocks) animateWithDuration:animations:] + 48
	10  TKTrade                             0x000000010b425f1b -[TKTradeFirstFloorViewController updateViewByAccountInfo:] + 203
	11  TKTrade                             0x000000010b320e8c __46-[TKNormalTradeViewController viewWillAppear:]_block_invoke + 1084
	12  TKTrade                             0x000000010b1c36c0 __61-[TKTradeService doQueryAccountAsset:moneyType:callBackFunc:]_block_invoke + 80
	13  TKTrade                             0x000000010b1c145b __51-[TKTradeService invoke:callBackFunc:isReturnList:]_block_invoke + 107
	14  libdispatch.dylib                   0x00000001149764a6 _dispatch_call_block_and_release + 12
	15  libdispatch.dylib                   0x000000011499f05c _dispatch_client_callout + 8
	16  libdispatch.dylib                   0x000000011498040b _dispatch_main_queue_callback_4CF + 411
	17  CoreFoundation                      0x0000000111f80909 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
	18  CoreFoundation                      0x0000000111f46ae4 __CFRunLoopRun + 2164
	19  CoreFoundation                      0x0000000111f46016 CFRunLoopRunSpecific + 406
	20  GraphicsServices                    0x0000000113a26a24 GSEventRunModal + 62
	21  UIKit                               0x000000010dd980d4 UIApplicationMain + 159
	22  TKTrade                             0x000000010b1c0a7f main + 111
	23  libdyld.dylib                       0x00000001149eb65d start + 1
	24  ???                                 0x0000000000000001 0x0 + 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException
```

# 3.什么时候考虑用copy？

```swift
nsstring 用strong 可以添加appent字符串，用copy和mutableCopy都不可以，因为他们生成的都是不可变的字符串。
详见：http://www.jianshu.com/p/e6a7cdcc705d

在平时使用的时候，我们在使用的时候要注意以下两种情况  


对外声明的容器或者组合类型的不可变数据：NSSet，NSString，NSArray，NSdictionary 等要使用copy。
@property (nonatomic, strong copy) NSString *name;     所以我们都要用copy修饰   
对外声明的容器或者组合类型的可变数据，要用strong，用copy修饰的，你内部修改这个值的时候会崩溃
@property (nonatomic, ~~ copy~~ strong) NSMutableString *name;     


情况一解释：  

       @property (nonatomic, ~~strong~~ `copy`) NSString *name;     所以我们都要用copy修饰   
       》 用的是strong或者retain
       1.如果该变量是不可变的，你的修改会引起外部变量的修改。
       2.如果该变量是可变的，那么外部修改这个对象的值会影响内部。
       》 用copy修饰的时候则不会，因为他会生成一份拷贝，避免了相互影响



栗子🌰:
声明：

#import <Foundation/Foundation.h>

@interface HSPerson : NSObject

@property (nonatomic, copy) NSString *name1;  ✅
@property (nonatomic, strong) NSString *name2;❌

@end


赋值

NSMutableString *string = [NSMutableString stringWithFormat:@"原始数据"];

HSPerson *person = [[HSPerson alloc] init];

// 不能改变person.name的值，因为其内部copy新的对象
person.name1 = string;
// 被改变 
person.name2 = string;

[string appendString:@" +++++被修改了"];

NSLog(@"name1 = %@", person.name1);
NSLog(@"name2 = %@", person.name2);


结果：

2017-05-19 14:01:39.961 aaaa[37494:1901421] name1 = 原始数据
2017-05-19 14:01:39.962 aaaa[37494:1901421] name2 = 原始数据 +++++被修改了


栗子🌰:
声明：

#import <Foundation/Foundation.h>

@interface HSPerson : NSObject

@property (nonatomic, copy) NSMutableString *name3;   
@property (nonatomic, strong) NSMutableString *name4;   

@end


赋值

NSMutableString *string = [NSMutableString stringWithFormat:@"汉斯哈哈哈"];

HSPerson *person = [[HSPerson alloc] init];
person.name = string;

// 不能改变person.name的值，因为其内部copy新的对象
[string appendString:@" hans"];

 NSLog(@"name = %@", person.name);


结果：

name 


情况二解释：


NSMutableString 作为属性的话，只要是self. 开头的赋值都会触发它的copy方法，这个时候得到的值是 NSTaggedPointerString类型的，这种也是不可修改的，（mutable的数据要用strong或者retain，因为用copy修饰的话，这个可变的变量又变成不可以变的了，不知道为何）
     
3.用MSMutable 和不用mutable 有什么优缺点？
     在多线程中，最好不要让别人修改你的数据，否则不好排查，所以函数传参数的时候最好不要设置成可变的。
     对外暴露的属性中，你如果希望被别人修改那么就修改成mutable的，如果不希望，则修改成不可变的。修改可变的是用strong，不可以变的是用copy 



5.为什么mutable的不能用copy属性？

```



assigned，retain，copy， readonly，__weak

 @property (nonatomic, readonly) UILabel *accessoryViewLable;
注意lable的用法，这里必须设置成readonly，防止别人修改，但是修改成这个属性一个后就不能够用self.accesoryViwlable 来访问了，因为他没有了set方法，只能这么访问，_accessoryViewLable = lable;



delegate为什么用assign

对象a创建并引用了对象b.对象b创建并引用了对象c.对象c创建并引用了对象b.
这时候b和c的引用计数分别是2和1。当a不再使用b，调用release释放对b的所有权，因为c还引用了b，所以b的引用计数为1，b不会被释放。b不释放，c的引用计数就是1，c也不会被释放。从此，b和c永远留在内存中。


