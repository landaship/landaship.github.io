//
//  LSMenusGroupModel.h
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSMenusGroupModel : NSObject

@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, copy) NSString *footer; // 尾部标题
@property (nonatomic, strong) NSArray *items; // 中间的条目

@end

NS_ASSUME_NONNULL_END
