# equalTo与mas_equalTo区别 

1.如何添加约束

2.如何设置居中对齐？

3.如何用masonry 布局这个页面？

如果约束条件是数值或者结构体等类型，可以使用mas_equalTo进行包装。关于这个问题，我也不是很清楚，可以看看官方的解释： Instead of using NSNumber, you can use primitives and structs to build your constraints.By default, macros which support autoboxing are prefixed with mas_. Unprefixed vers

如何添加约束：
   [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Weakself.pageView);
        make.left.equalTo(Weakself.pageView);
        make.right.equalTo(Weakself.pageView);
        make.bottom.equalTo(Weakself.pageView);
    }];

