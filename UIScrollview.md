# masonry 的自动布局方案

// 我草，加了这句话就不会出现多出44高度的不适应了
    self.automaticallyAdjustsScrollViewInsets = NO;
   
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


1.关于UIScrollView的布局

scrollView几个代理事件的处理：执行顺序
// contenOffset只要被改变就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
// 如果产生了减速动画（有那种回弹的效果），则在减速完成时触发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView 
// 结束减速时触发，一次有效的滑动只执行一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

