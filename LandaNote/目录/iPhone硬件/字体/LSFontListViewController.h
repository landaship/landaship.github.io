//
//  LSFontListViewController.h
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSFontListViewController : UIViewController

@end

@interface LSFontListModel : NSObject
@property(nonatomic,copy)NSString *familyName;
@property(nonatomic,strong)NSArray *fontNames;
@end

NS_ASSUME_NONNULL_END
