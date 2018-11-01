//
//  LSMenusConfigHelper.h
//  TKApp
//
//  Created by 陈桂民 on 2018/4/23.
//  Copyright © 2018年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSMenusGroupModel.h"
#import "LSMenusCellModel.h"
#import "LSStringHelper.h"

@interface LSMenusConfigHelper : NSObject

+(LSMenusConfigHelper *)shareInstance;//单例

@property (nonatomic, strong)NSArray *firstMenus;

@end
