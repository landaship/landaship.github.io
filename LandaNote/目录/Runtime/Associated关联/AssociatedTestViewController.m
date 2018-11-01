//
//  AssociatedTestViewController.m
//  LandaNote
//
//  Created by Louis on 2018/11/1.
//  Copyright © 2018 Landaship. All rights reserved.
//

//参考：雷纯峰 http://blog.leichunfeng.com/blog/2015/06/26/objective-c-associated-objects-implementation-principle/

#import "AssociatedTestViewController.h"
#import "AssociatedTestViewController+AssociatedObjects.h"

@interface AssociatedTestViewController ()

@end

// 全局变量，用__weak 修饰，可以用来模拟对象
// 取消掉__weak 后watchpoint 就不会再hit了，为什么？
// 答：因为__weak的作用，关联的对象被释放了，它也被释放并设置成nil，产生一个新的值，所以才再次触发hit
__weak NSString *string_weak_assign = nil;

// __weak 作用：1.对象被释放后被设置为nil 2.把对象加入autoReleasePool中，保证对象在autoReleasePool 结束之前都能存在
// ？？ autoReleasePool 是什么时候创建，什么时候结束的？
// 答AutoreleasePool是在RunLoop即将进入RunLoop和准备进入休眠这两种状态的时候被创建和销毁的。
// 那RunLoop 是不是可以同时存在多个？也就是会同时存在多个pool
// 答：一个线程一个runloop，也可能有线程不开启runloop，所以都会有多个
// 回到这个问题，当前是在主线程操作，所以这里程序不杀，这个对象是不会被销毁的
// 但是这里不用weak应该也是一样的效果啊，为何要加weak？见上面string_weak_assign的分析
__weak NSString *string_weak_retain = nil;
__weak NSString *string_weak_copy   = nil;

@implementation AssociatedTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    // 建立ViewController 和 NSString的关联
    self.associatedObject_assign = [NSString stringWithFormat:@"leichunfeng1"];
    self.associatedObject_retain = [NSString stringWithFormat:@"leichunfeng2"];
    self.associatedObject_copy   = [NSString stringWithFormat:@"leichunfeng3"];
    
    // 获取关联的对象
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    string_weak_assign = self.associatedObject_assign;
    string_weak_retain = self.associatedObject_retain;
    string_weak_copy   = self.associatedObject_copy;
    //    });
    /* Tips
    可以在设置设置watchpoint set v string_weak_assign
     来监听 string_weak_assign 被修改的情况
    */
}

// 系统的触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    NSLog(@"self.associatedObject_assign: %@", self.associatedObject_assign); // Will Crash
    NSLog(@"self.associatedObject_retain: %@", self.associatedObject_retain);
    NSLog(@"self.associatedObject_copy:   %@", self.associatedObject_copy);
}

@end
