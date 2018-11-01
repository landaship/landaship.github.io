//
//  LSMenusCellModel.h
//  TKApp
//
//  Created by Louis on 2018/5/13.
//  Copyright © 2018年 liubao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LSDefineHeader.h"

@interface LSMenusCellModel : NSObject <NSCopying,NSCoding,NSMutableCopying>

@property (nonatomic, copy) NSString * descriptionStr;// 描述文字
@property (nonatomic, copy) NSString * webURL;// H5控制器对应的地址
@property (nonatomic, copy) NSString * ctrlName;//控制器名字
@property(nonatomic, copy)NSString *titleStr;  // 标题
@property(nonatomic, copy)NSString *iconName;   // 图标名称
@property(nonatomic, assign)BOOL isCheckLogin;      // 是否检测登录，0，否，1，是，默认选择是
@property(nonatomic, assign)NSInteger tabIndex;     // 需要跳转到的页面，index是序号,用于跳转到多个tab的页面
@property(nonatomic, copy)NSString *className; // 该cell要跳转到的菜单控制器的名称
@property(nonatomic, copy) LSCallBackBlock didClickedCellBlock;
@property(nonatomic, assign)BOOL isSelected;      // 是否被选中

@end
