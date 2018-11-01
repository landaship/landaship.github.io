    # masonry 的自动布局方案

## 1. 我草，加了这句话就不会出现多出44高度的不适应了

```swift
self.automaticallyAdjustsScrollViewInsets = NO;
```
   
## 2. scrollView 自动布局代码
```   
__weak typeof (&*self)ws = self;
   
// 装每个page的容器
UIView *contentView = [UIView new];
contentView.backgroundColor = [UIColor yellowColor];
[self.myScrollView addSubview:contentView];
   
[contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(ws.myScrollView).insets(UIEdgeInsetsZero);
    make.height.equalTo(ws.myScrollView.mas_height);
}];
 
UIView *firstView = [UIView new];
firstView.backgroundColor = [UIColor blueColor];
[contentView addSubview:firstView];
   
[firstView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(contentView.mas_left).offset(kMargin);
    make.top.equalTo(contentView.mas_top).offset(kMargin);
    make.bottom.equalTo(contentView.mas_bottom).offset(-kMargin);
    make.width.equalTo(ws.myScrollView.mas_width).offset(-2*kMargin);
}];
   
UIView *lastView = firstView;
for (int i=0; i<KPageNum; i++) {
UIView *newView = [UIView new];
[contentView addSubview:newView];
newView.backgroundColor = [self randomColor];
[newView mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.equalTo(lastView.mas_right).offset(2*kMargin);
  make.top.equalTo(firstView.mas_top);
  make.height.equalTo(firstView.mas_height);
  make.width.equalTo(lastView.mas_width);
}];
  
lastView = newView;
}
   
[contentView mas_updateConstraints:^(MASConstraintMaker *make) {
make.width.equalTo(ws.myScrollView.mas_width).multipliedBy(KPageNum);
make.height.equalTo(ws.myScrollView.mas_height);
}];

```

## 3.scrollView几个代理的触发事件

contenOffset只要被改变就会触发

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
```

如果产生了减速动画（有那种回弹的效果），则在减速完成时触发

```
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView 
```

结束减速时触发，一次有效的滑动只执行一次

```
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
```

## 4.contentSize、contentOffset、contentInset的整理
CGSize    contentSize 

```
是指可滚动的区域，frame 是指可以看得到的scrollView的大小，
如frame 是{0,0,320,480},contenSize 是{320,960},
说明可以垂直移动两个可见区域的大小
```
CGPoint   contentOffset
![](media/15372423552540.jpg)

```
这个是指contenView左上角原点的偏移量，
CGPoint，x表示距离scrollview横轴的距离，y表示纵轴的距离
```

UIEdgeInsets    contentInset 
![](media/15372421419503.jpg)

```
用来标示contentView上下左右距离scrllview 边框的距离，
可以用来做内边距，还有动态移动tableview的位置，如键盘弹出，顶高tableview
```


## 5.ScrollView中有UIPanGestureRecognizer
再MJRefresh中使用到了他的eTKTradeChartPanGestureState 做一个状态判断，实际上在iOS11 手机上测试的时候，有时候并不能完全收到这几个状态。可以查看手势状态的介绍。


