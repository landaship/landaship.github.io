//
//  ViewController.m
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#import "ViewController.h"
#import "LSMenusConfigHelper.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *dataArr;
@end
// 全局变量，声明周期等同于程序生命周期
__weak NSString *globalStr = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"笔记";
    self.dataArr = [LSMenusConfigHelper shareInstance].firstMenus;
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
    
    LSMenusGroupModel *group = self.dataArr[indexPath.section];
    LSMenusCellModel *cellUIInfo = group.items[indexPath.row];
    cell.textLabel.text = cellUIInfo.titleStr;
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
    LSMenusGroupModel *group = self.dataArr[section];
    NSArray *items = group.items;
    return items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LSMenusGroupModel *group = self.dataArr[section];
    if ([LSStringHelper isEmpty:group.header]) {
        return 10;
    }else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [UIView new];
    CGFloat labelHeight = CGFLOAT_MIN;
    headerView.backgroundColor = [UIColor darkGrayColor];
    LSMenusGroupModel *group = self.dataArr[section];
    if (![LSStringHelper isEmpty:group.header]) {
        labelHeight = 50;
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kTradeScreenWidth - 20*2, labelHeight)];
    label.font = [UIFont systemFontOfSize:20.0];
    label.textColor = kTradeTextColorLevel1;
    label.text = group.header;
    [headerView addSubview:label];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LSMenusGroupModel *group = self.dataArr[indexPath.section];
    LSMenusCellModel *info = group.items[indexPath.row];
    NSString *className = info.className;
    if ([LSStringHelper isEmpty:className]) {
        return;
    }
    Class class = NSClassFromString(className);
    NSString *ctrlName = info.ctrlName;
    if ([LSStringHelper isEmpty:ctrlName]) {
        ctrlName = className;// 如果不指定控制器名字则以类名作为控制器名字
    }
    UIViewController *newCtrl = [class new];
    if (newCtrl == nil) {
        // push 一个nil的控制器会导致后续的push都无法push
        NSLog(@"###控制器配置错误！类名：%@", className);
        return;
    }
    newCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newCtrl animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
@end
