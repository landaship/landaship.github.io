//
//  LSFontListViewController.m
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#import "LSFontListViewController.h"
#import "LSDefineHeader.h"

@interface LSFontListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *dataArr;
@end

@implementation LSFontListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *familyArr = [NSMutableArray array];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        LSFontListModel *model = [LSFontListModel new];
        NSMutableArray *fontNamesArr = [NSMutableArray array];
        
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            [fontNamesArr addObject:fontName];
            printf( "\t字体名称: %s \n", [fontName UTF8String] );
        }
        model.fontNames = fontNamesArr;
        model.familyName = familyName;
        [familyArr addObject:model];
    }
    
    self.dataArr = familyArr;
    
    self.navigationItem.title = @"ios 字体";
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    LSFontListModel *group = self.dataArr[indexPath.section];
    NSString *fontName = group.fontNames[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:0123456789字体",fontName];
    UIFont *font = [UIFont fontWithName:fontName size:16.0f];
    cell.textLabel.font = font;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LSFontListModel *group = self.dataArr[section];
    NSArray *items = group.fontNames;
    return items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor darkGrayColor];
    CGFloat labelHeight = CGFLOAT_MIN;
    LSFontListModel *group = self.dataArr[section];
    labelHeight = 50;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kTradeScreenWidth - 20*2, labelHeight)];
    label.font = [UIFont systemFontOfSize:20.0];
    label.textColor = kTradeTextColorLevel1;
    label.text = group.familyName;
    [headerView addSubview:label];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSFontListModel *group = self.dataArr[indexPath.section];
    NSString *fontName = group.fontNames[indexPath.row];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = fontName;
    
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:nil message:@"已经复制到剪贴板" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [aler show];
}
@end


@implementation LSFontListModel


@end
