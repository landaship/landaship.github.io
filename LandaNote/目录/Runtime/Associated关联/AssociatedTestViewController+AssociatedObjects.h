//
//  AssociatedTestViewController+AssociatedObjects.h
//  AssociatedObjects
//
//  Created by leichunfeng on 15/6/25.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "AssociatedTestViewController.h"

@interface AssociatedTestViewController (AssociatedObjects)

// 这种变量很容易引起崩溃，切记
@property (assign, nonatomic) NSString *associatedObject_assign;
@property (strong, nonatomic) NSString *associatedObject_retain;
@property (copy,   nonatomic) NSString *associatedObject_copy;

+ (NSString *)associatedObject;
+ (void)setAssociatedObject:(NSString *)associatedObject;

@end
