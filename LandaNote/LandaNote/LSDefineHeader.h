//
//  LSDefineHeader.h
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#ifndef LSDefineHeader_h
#define LSDefineHeader_h

#define WS(weakSelf) __weak typeof(self)weakSelf = self
#define kTradeScreenWidth [UIScreen mainScreen].bounds.size.width
#define kTradeScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTradeMainColor             [UIColor redColor]
// 背景色-浅灰
#define kTradeBackGroundColor          [UIColor redColor]
// 分割线-灰CCCCCC
#define kTradeSprateLineColor          [UIColor redColor]
// 浅灰文字
#define kTradeTextColorLevel1         [UIColor redColor]
// 中灰文字
#define kTradeTextColorLevel2         [UIColor redColor]
// 深灰文字
#define kTradeTextColorLevel3          [UIColor redColor]
// 黑色文字
#define kTradeTextColorLevel4          [UIColor redColor]
// 可点击文字
#define kTradeClickableTextColor         [UIColor redColor]

typedef void(^LSEmptyBlock)(void);
typedef void(^LSCallBackBlock)(id userInfo);

#endif /* LSDefineHeader_h */
