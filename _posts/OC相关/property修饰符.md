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


