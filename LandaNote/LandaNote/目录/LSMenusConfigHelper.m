//
//  LSMenusConfigHelper.m
//  TKApp
//
//  Created by 陈桂民 on 2018/4/23.
//  Copyright © 2018年 liubao. All rights reserved.
//

#import "LSMenusConfigHelper.h"

@interface LSMenusConfigHelper()

@property(nonatomic, retain)NSDictionary *configDic;// 交易首页UI配置字典

@end

@implementation LSMenusConfigHelper

+(LSMenusConfigHelper *)shareInstance
{
    static LSMenusConfigHelper *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
        [manager loadTradeHomeConfigurations];
    });
    return manager;
}

#pragma mark 读取plist 数据
-(void)loadTradeHomeConfigurations{
    if (self.configDic == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LSMenusConfig" ofType:@"plist"];
        if ([LSStringHelper isEmpty:path]) {
            NSLog(@"TKTradeHomeUIConfig.plist找不到！");
        }else{
            self.configDic = [NSDictionary dictionaryWithContentsOfFile:path];
        }
    }
}

-(NSArray *)firstMenus{
    NSDictionary *homeUIDicTmp = self.configDic[@"FirstMenus"];
    if (homeUIDicTmp) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        NSArray *verticalMenus = homeUIDicTmp[@"verticalMenus"];
        for (NSDictionary *tmpDic in verticalMenus) {
            LSMenusGroupModel *group = [[LSMenusGroupModel alloc]init];
            group.header = tmpDic[@"sectionHeaderStr"];
            group.footer = tmpDic[@"sectionFooterStr"];
            
            NSMutableArray *mutableItems = [NSMutableArray array];
            NSArray *items = tmpDic[@"Items"];
            for (NSDictionary *cellDic in items) {
                LSMenusCellModel *cellModel = [[LSMenusCellModel alloc]init];
                cellModel.className = cellDic[@"className"];
                cellModel.titleStr = cellDic[@"titleStr"];
                cellModel.iconName = cellDic[@"iconName"];
                cellModel.descriptionStr = cellDic[@"descriptionStr"];
                cellModel.tabIndex = [cellDic[@"tabIndex"] integerValue];
                cellModel.webURL = cellDic[@"webViewURL"];
                cellModel.ctrlName = cellDic[@"ctrlName"];
                [mutableItems addObject:cellModel];
            }
            group.items = mutableItems;
            [tmpArr addObject:group];
        }
        
        return tmpArr;
    }else{
        return nil;
    }
}

@end
