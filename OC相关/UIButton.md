# 当图片是disapble的时候会自动减淡图片颜色，这个时候需要：   btn.enabled = NO;  // 取消按钮响应事件
    btn.adjustsImageWhenDisabled = NO;  // 防止按下的时候按钮变颜色



Button正常情况下图片在左边，文字在右边
想翻过来怎么处理？

```swift
5 代表按钮和文字的间距，注意这里可能会超过Button的Frame，注意布局上的事情
 [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -backBtn.imageView.image.size.width+5, 0, backBtn.imageView.image.size.width-5)];
 [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, backBtn.titleLabel.bounds.size.width, 0, -backBtn.titleLabel.bounds.size.width)];
```

思路：各自设置偏移量，达到左右互换
其中'-','+'分别表示向外移动，向中心移动，如+20 ，向Btn内部缩进20，-20，向Btn外部扩张20
方法：**UIEdgeInsetsMake**
具体作用: ***设置拉伸的边距***
参考：https://www.jianshu.com/p/0d3dbc30fad5

# 2.去掉点击选择的状态

