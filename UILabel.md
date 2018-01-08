# 文字加阴影：
label.shadowColor = [UIColoryellowColor];
label.shadowOffset =CGSizeMake(3,3);

label masonry 自适应高度

 // 添加文字
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        name.textAlignment = NSTextAlignmentLeft;
        name.numberOfLines = 0;
        name.font = [UIFont systemFontOfSize:14.0f];
        name.text = _titles[i];
        name.preferredMaxLayoutWidth = 100;
        [name setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        name.textColor = [TKUIHelper colorWithHexString:@"333333"];
        [self addSubview:name];
  [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(point.mas_right).offset(15);
            make.centerY.equalTo(point.mas_centerY);
        }];

