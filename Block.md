# 1.what is Blocks?
     带有自动变量的匿名函数。
     解析：
          自动变量：变量分为很多种，静态全局变量，静态局部变量，函数参数，局部变量（为什么称之为自动变量），全局变量

// block 得用copy属性,block的retain行为默认是用copy的行为实现的，因为block变量默认是声明为栈变量的，为了能够在block的声明域外使用，所以要把block拷贝（copy）到堆，所以说为了block属性声明和实际的操作一致，最好声明为copy。
@property (nonatomic, copy) TKAnyChatToolsBlock block;    // 结果处理block


#pragma mark anyChat释放本地视频
- (void) OnLocalVideoRelease:(id)sender
{
    _block(NO, nil);
}

   TKCallCenterViewController *__weak weakSelf = self;
    _tools.block = ^(BOOL start, id session)
    {
        NSLog(@"++++++++++start:%d", start);
        [weakSelf TKAnyChatStatusDelegate:start session:session];
    };

