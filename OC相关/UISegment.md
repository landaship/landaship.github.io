# 1.修改属性
  NSArray *titleArr = @[@"实时直播",@"专题精选"];
    _segmentCtrl = [[UISegmentedControl alloc]initWithItems:titleArr];
    _segmentCtrl.frame = CGRectMake(0, 0, 200, 30);
    _segmentCtrl.selectedSegmentIndex = 0;
    [_segmentCtrl setTintColor: [TKUIHelper colorWithHexString:@"FFFFFF"]];
    [self.navigationItem setTitleView:_segmentCtrl];
    
    // 未选中的颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [TKUIHelper colorWithHexString:@"FFFFFF"],
                         NSForegroundColorAttributeName ,
                         [UIFont fontWithName:@"SnellRoundhand-Bold"size:14],
                         NSFontAttributeName ,
                         nil];
    
    // 选中时的颜色和字体
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [TKUIHelper colorWithHexString:@"EA333C"],
                                 NSForegroundColorAttributeName,
                                 [UIFont fontWithName:@"SnellRoundhand-Bold"size:14],
                                 NSFontAttributeName  ,nil];
    [_segmentCtrl setTitleTextAttributes:dic forState:UIControlStateNormal];
    [_segmentCtrl setTitleTextAttributes:dicSelected forState:UIControlStateSelected];

