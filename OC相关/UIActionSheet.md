# UIActionSheet
> 模态切换的作用是：在点击一个按钮或者一个事件触发的情况下，会弹出一个视图，这个视图不依赖于任何View，出现完了就消失的那种。这个模态视图也是由ViewController来控制，里面也是独立的view显示控制，只不过它通过两个方法来实现弹出和消失。



记得设置切换样式的时候要设置被弹出的模态视图Viewcontroller的style不是他父类的style哦



* 下面是UIActionSheet的使用方法


```swift
UIActionSheet *logoutActionSheet = [[UIActionSheet alloc]initWithTitle:@"退出" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"这个是"otherButtonTitles:@"nage", nil];
    
logoutActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
[logoutActionSheet showInView:self.view];
```

