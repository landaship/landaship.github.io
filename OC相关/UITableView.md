[TOC]
## 1.为何 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section会被调用三次

```
答：因为 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView被调用了三次
```

## 2.为何 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView被调用了三次
```
答：目前没有找到相关证据，只知道无论你返回值写多少，都会被调用三次
```
## 3.plain和group的区别
```swift
plain有段头停留（在tableview的代理中从写scrollview的代理就可以解决
/**
重写scrollview代理方法，防止段头停留
@param
 scrollView
 */
- (
void)scrollViewDidScroll:(UIScrollView
 *)scrollView {
CGFloat sectionHeaderHeight = 30
;
    
if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0
) {
        scrollView.
contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0
);
    } 
else if (scrollView.contentOffset.y
>=sectionHeaderHeight) {
        scrollView.
contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0
);
    }
}
）
group没有，但是group需要手动去掉头尾高度
http://blog.csdn.net/que_li/article/details/49640535


tableviewcell的textlabel 是懒加载的，如果你不做初始化赋值操作，他是不会被初始化添加到view上的
```
## 4.设置cell没有选中的高亮效果：
```swift
cell.selectionStyle = UITableViewCellSelectionStyleNone;
[tableView deselectRowAtIndexPath:indexPath animated:YES];
```
## 5.tableview section header 重用
http://blog.csdn.net/longzs/article/details/51364284

## 6.同一个项目中cell的identify是不是可以一样？
```
回答：是的，因为这个一个table会有一个对应的从用数组，只要你这个table的cell区分开来就好，不会影响其他的table的。
```

## 7.indentationWidth 作用
```swift
cell.indentationLevel = 10; // 设置cell的文字靠左边的距离，10*默认的10，也就是100，
--indentationLevel属性：adjust content indent. default is 0.The amount of indentation is equal to theindentation level multiplied by the value in theindentationWidth property。即indentation = indentationLevel * indentationWidth；


--indentationWidth属性：width for each level. default is 10.0。
我擦， -(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath 会导致didSelectRowAtIndexPath无用
```

## 8.cell的重用机制：
```
当一个cell已经滚出了view的范围的时候，滚出去的cell会被放到重用队列里面，等下一个cell要展示的时候，再将它从重用队列里面取出来，然后从新填充数据，所以每个cell重新出来的时候高度是要从新计算的

好处：减少内存开销，

```

## 9.如何制作目录缩进效果
```swift
-(NSInteger)tableView:(UITableView*)tableView indentationLevelForRowAtIndexPath:(NSIndexPath
*)indexPath
{
    if(indexPath.row%2) {     
        return12;
     }
     return20;
}

```
## 10.如何去掉cell和cell之间的分割线？
```swift
 self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
```
## 11.底部扩充10个像素
```swift
 self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
```

## 12.为什么Identify要用static的string 来声明？
没有必要用static，NSString本来就是在静态存储区域的，用了static它还是在静态存储区域两个地址是一样的：

```swift
NSString *aaa = @"d";
static NSString *bbb = @"d";
NSLog(@"+++%p, %p", aaa,bbb);
```
日志输出
```log
2017-06-08 21:34:49.458 weraweqwe[61855:1165332] +++0x10337a068, 0x10337a068
```

## 13.endR额fresh为何会触发cell的reload动作？
因为endRefresh会调整头的高度，这个UI调整动作会触发cell的重用机制。

## 14.UITableView 添加了tableFooterView以后contensize会有一个默认高度，高度不固定，如果用来调整tableview高度的话要注意了（股交TKHqNewsViewController）
 _mainView.tableFooterView = [UIView new];
 

## 如何在uitaleview reloadData后再执行操作
 
### 1. 通过layoutIfNeeded方法，强制重绘并等待完成。

```swift
[self.tableView reloadData];  
[self.tableView layoutIfNeeded];  
//刷新完成，执行后续需要执行的代码
```

### 2.reloadData方法会在主线程执行，通过GCD，使后续操作排队在reloadData后面执行。

```swift
[self.tableView reloadData];  
dispatch_async(dispatch_get_main_queue(), ^{  
    //刷新完成，执行后续代码
});
```




