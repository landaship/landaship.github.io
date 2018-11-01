//
//  LSScrollViewTestViewController.m
//  LandaNote
//
//  Created by 719 on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

#import "LSScrollViewTestViewController.h"

typedef NS_ENUM(NSInteger,eTKTradeChartViewState){
    eTKTradeChartViewState_Hide,  // 隐藏状态
    eTKTradeChartViewState_Show// 正在展示的状态
};

typedef NS_ENUM(NSInteger,eTKTradeChartPanGestureState){
    eTKTradeChartPanGestureState_Idle,// 无状态
    eTKTradeChartPanGestureState_UP,  // 向上
    eTKTradeChartPanGestureState_Down,// 向下
    eTKTradeChartPanGestureState_Left,// 向左
    eTKTradeChartPanGestureState_Right// 向右
};
@interface LSScrollViewTestViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)eTKTradeChartViewState chartViewState;
@property (nonatomic, assign)CGFloat chartViewHeight;
@property (nonatomic, strong)UIView *chartView;

@end

@implementation LSScrollViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartViewHeight = 170;
    self.navigationController.navigationBar.translucent = NO;
    
    //    //实例化对象(里面有init,UIRefreshControl的初始化)
    //    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    //
    //    //设置UIRefreshControl控件的颜色(菊花和文字)
    //    control.tintColor = [UIColor redColor];
    //    [self.tableView addSubview:control];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat scrollViewH = self.view.frame.size.height;
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(width, scrollViewH);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 300)];
    label.text = @"我是占位用的";
    [self.scrollView addSubview:label];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0];
    [label addGestureRecognizer:tap];
    
    CGFloat tableViewY = CGRectGetMaxY(label.frame);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableViewY, width, scrollViewH - tableViewY) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.tableView];
    
    UIView *chartView = [[UIView alloc]initWithFrame:CGRectMake(0, -170, width, 170)];
    [self.scrollView insertSubview:chartView atIndex:0];
    chartView.backgroundColor = [UIColor greenColor];
    self.chartView = chartView;;
}

-(void)onTap{
    CGFloat width = self.view.frame.size.width;
    //    if (self.num == 3) {
    //        self.num = 60;
    //    }else{
    //        self.num = 3;
    //    }
    self.num = 3;
    CGFloat height = self.tableView.frame.origin.y + 40*self.num + 64;
    
    CGRect frame =  self.tableView.frame;
    CGFloat tmpH = 40*self.num;
    
    if (frame.size.height > tmpH) {
        height = frame.size.height + self.tableView.frame.origin.y + 64 + 1;
    }else{
        frame.size.height = tmpH;
    }
    self.tableView.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(width, height);
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSString *text = [NSString stringWithFormat:@"我是-%zd",indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.num;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

#pragma mark 动态隐藏

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@">>>>>>scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@">>>>>>scrollViewDidEndDragging");
    CGPoint offset = scrollView.contentOffset;
    CGFloat respondAreaH = 25;// 感应区高度，用户拖拽距离超过这个高度则认为他有拖拽的操作
    if (self.chartViewState == eTKTradeChartViewState_Hide) {
        // 隐藏模式下，偏移量在小于-50的，就认为用户有下拉操作
        if (offset.y < -(respondAreaH )) {
            self.chartViewState = eTKTradeChartViewState_Show;
        }
    }else if (self.chartViewState == eTKTradeChartViewState_Show){
        // 显示模式下，偏移量在{-（chartViewHeight-50）,scrollViewContentHeight}之间的认为有上拉操作
        if (offset.y > -(self.chartViewHeight  - respondAreaH)){
            self.chartViewState = eTKTradeChartViewState_Hide;
        }
    }else{
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    UIGestureRecognizerState panState = pan.state;
    CGPoint offset = scrollView.contentOffset;
    CGPoint panPoint = [pan translationInView:self.scrollView];
    eTKTradeChartPanGestureState state = [self commitTranslation:panPoint];
    
    //    CGFloat happenOffsetY = -self.scrollView.adjustedContentInset.top;
    CGFloat respondAreaH = 25;// 感应区高度，用户拖拽距离超过这个高度则认为他有拖拽的操作
    //    if (state == eTKTradeChartPanGestureState_UP) {
    //        if (offset.y > -(happenOffsetY + self.chartViewHeight)) {
    //            self.chartViewState = eTKTradeChartViewState_Hide;
    //        }else{
    //            self.chartViewState = eTKTradeChartViewState_Pulling;
    //        }
    //    }else if(eTKTradeChartPanGestureState_Down == state) {
    //        if (offset.y < -(happenOffsetY + respondAreaH)) {
    //            self.chartViewState = eTKTradeChartViewState_Show;
    //        }else{
    //            self.chartViewState = eTKTradeChartViewState_Pulling;
    //        }
    //    }
    NSLog(@"offset:%@,panState:%ld",NSStringFromCGPoint(offset),panState);
    
    switch (panState) {
        case UIGestureRecognizerStatePossible:{
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        }
        case UIGestureRecognizerStateBegan:{
            NSLog(@"UIGestureRecognizerStateBegan");
            break;
        }
        case UIGestureRecognizerStateChanged:{
            NSLog(@"++");
            break;
        }
        case UIGestureRecognizerStateEnded:{
            NSLog(@"UIGestureRecognizerStateEnded");
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"UIGestureRecognizerStateCancelled");
            break;
        }
            
        case UIGestureRecognizerStateFailed:{
            NSLog(@"UIGestureRecognizerStateFailed");
            break;
        }
        default:
            break;
    }
    if (panState == UIGestureRecognizerStateEnded){
        //        NSLog(@"UIGestureRecognizerStateEnded");
        
    }else if (panState == UIGestureRecognizerStateChanged){
        //        NSLog(@"UIGestureRecognizerStateChanged");
        
        //        if (self.chartViewState == eTKTradeChartViewState_Hide) {
        //            // 隐藏模式下，偏移量在小于-50的，就认为用户有下拉操作
        //            if (offset.y < -(respondAreaH )) {
        //                self.chartViewState = eTKTradeChartViewState_Show;
        //            }
        //        }else if (self.chartViewState == eTKTradeChartViewState_Show){
        //            // 显示模式下，偏移量在{-（chartViewHeight-50）,scrollViewContentHeight}之间的认为有上拉操作
        //            if (offset.y > -(self.chartViewHeight  - respondAreaH)){
        //                self.chartViewState = eTKTradeChartViewState_Hide;
        //            }
        //        }else{
        //
        //        }
    }else{
        //        NSLog(@"%d",panState);
    }
    
    //    NSLog(@"\noffset:%@,\npanPoint:%@",NSStringFromCGPoint(offset),NSStringFromCGPoint(panPoint));
    //    if (panState == UIGestureRecognizerStateEnded) {// 手松开
    //        if (offset.y >= self.chartViewHeight) { // 向上拽
    //            [self beginRefreshing];
    //        }
    //
    //    } else if (panState == UIGestureRecognizerStateBegan) {
    //        self.oneNewPan = YES;
    //    }
}

/** 判断手势方向  */
- (eTKTradeChartPanGestureState)commitTranslation:(CGPoint)translation {
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    CGFloat respondAreaH = 50;// 感应区高度，用户拖拽距离超过这个高度则认为他有拖拽的操作
    // 设置滑动有效距离
    if (MAX(absX, absY) < respondAreaH)
        return eTKTradeChartPanGestureState_Idle;
    if (absX > absY ) {
        if (translation.x<0) {//向左滑动
            return eTKTradeChartPanGestureState_Left;
        }else{//向右滑动
            return eTKTradeChartPanGestureState_Right;
        }
    } else if (absY > absX) {
        if (translation.y<0) {//向上滑动
            return eTKTradeChartPanGestureState_UP;
        }else{ //向下滑动
            return eTKTradeChartPanGestureState_Down;
        }
    }
    
    return eTKTradeChartPanGestureState_Idle;
}

-(void)setChartViewState:(eTKTradeChartViewState)chartViewState{
    _chartViewState = chartViewState;
    if (_chartViewState == eTKTradeChartViewState_Hide) {
        NSLog(@"隐藏");
        // 恢复inset和offset
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.scrollView.contentInset;
            inset.top = 0;
            self.scrollView.contentInset = inset;
        } completion:^(BOOL finished) {
            // 可添加结束动画回调
        }];
    }else if (_chartViewState == eTKTradeChartViewState_Show) {
        NSLog(@"显示");
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(weakSelf) self = weakSelf;
            {
                [UIView animateWithDuration:0.25 animations:^{
                    if (self.scrollView.panGestureRecognizer.state != UIGestureRecognizerStateCancelled) {
                        // 增加滚动区域top
                        UIEdgeInsets inset = self.scrollView.contentInset;
                        inset.top = self.chartViewHeight;
                        self.scrollView.contentInset = inset;
                        
                        // 设置滚动位置
                        CGPoint offset = self.scrollView.contentOffset;
                        offset.y = -self.chartViewHeight;
                        [self.scrollView setContentOffset:offset animated:NO];
                    }
                } completion:^(BOOL finished) {
                    //可以添加执行展示分时图回调
                }];
            }
        });
    }else{
        NSLog(@"拖拽");
    }
}

@end
