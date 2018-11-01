//
//  LSStringHelper.m
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#import "LSStringHelper.h"

@implementation LSStringHelper
+(BOOL)isEmpty:(NSString *)str{
    if (str.length == 0 || str == nil || [str isKindOfClass:[NSNull class]]) {
        return YES;
    }else{
        return NO;
    }
}
@end
