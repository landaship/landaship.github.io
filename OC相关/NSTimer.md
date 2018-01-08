# NSTimer的几种初始化方式

一共有8种初始化方式，其中6种静态方法（类方法）初始化，2种动态方法.  
带block形式的都是10以后的API

```
10.0 以后才可以用的
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));
- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));


2.0 以后可以用的
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(nullable id)ui repeats:(BOOL)rep NS_DESIGNATED_INITIALIZER;
```
# 1. scheduledTimerWithTimeInterval的方法
## 1.1   + scheduledTimerWithTimeInterval: repeats: block:

注意：10.0以后才可以用  
例子：

```
[NSTimer scheduledTimerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
}];
```
## 1.2 + scheduledTimerWithTimeInterval: target: selector: userInfo: repeats:

例子：

```
NSTimer*_reOpenVideoTimer; // 20秒从新接象计时器
// 启动定时器
_reOpenVideoTimer = [NSTimer scheduledTimerWithTimeInterval:20
                                                        target:self
                                                      selector:@selector(alertNetSick)
                                                      userInfo:nil
                                                       repeats:NO]
// 销毁定时器
if ([_reOpenVideoTimer isValid]) {
     [_reOpenVideoTimer invalidate];
    _reOpenVideoTimer = nil;
}
```

参数解析:

```
userInfo:timer 事件触发的时候可以传递这个对象给事件。这个对象会被timer强持有。
-(void)test:(NSTimer *)timer
{
    id userInfo = timer.userInfo;
}
```

## 1.3 + scheduledTimerWithTimeInterval: invocation: repeats:
可以传递多参数数目的方式，重点在于NSInvocation 的用法，其他是一样的

# 2.需要自己添加到runloop中的初始化方式
##  2.1 + timerWithTimeInterval:invocation:repeats:
 (仅在iOS10 以后生效)

## 2.2 + timerWithTimeInterval:repeats:block:
(仅在iOS10 以后生效)
## 2.3 + timerWithTimeInterval:target:selector:userInfo:repeats:
(2.0以后 以后生效)

例子：

```swift
[NSTimer timerWithTimeInterval:10 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:YES];
      
//必须手动加入到当前循环中去
NSRunLoop *runloop=[NSRunLoop currentRunLoop];
[runloop addTimer:_timer forMode:NSDefaultRunLoopMode];
```

## 2.4 – initWithFireDate:interval:target:selector:userInfo:repeats:

常用的方法,重点在于FireDate:(NSDate *)date的设置
例子：

```
// 启动定时器
self.timer = [[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:0] interval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) 
{
     [timer invalidate];
     timer = nil;
}];
```

## 2.4 - initWithFireDate: interval:repeats: block:
注意还有一个很容易混淆的，只有10.0以后才能用的方法

# 3.fire 方法到底是干嘛的？
就是提前触发一下timer事件。
分两种情况：
+ 1.如果timer 是repeat的。
    那么这个会提前触发timer事件，但是到了他预定的时间后他还是会再触发，也就是说不影响之前的事件。如设置10秒触发一个事件，你3秒的时候触发了，10秒的时候还是会继续触发。
+ 2.timer 是不repeat的
    这个会触发事件，但是触发完了以后，timer会被invalidated 
官方解释：

```
You can use this method to fire a repeating timer without interrupting its regular firing schedule. If the timer is non-repeating, it is automatically invalidated after firing, even if its scheduled fire date has not arrived.
```

# 4.屏幕滚动的时候timer 为什么会停止？
在滚动的时候timer会停止：只需要改一下他的模式就可以，默认是NSDefaultRunLoopMode，因为滚动也是在这个模式下，所以改成NSRunLoopCommonModes模式就可以了。

NSRunLoopCommonModes 这是一组可配置的通用模式

参考：http://blog.csdn.net/chengyingzhilian/article/details/8185669
runloop介绍
http://www.cnblogs.com/mddblog/p/6435510.html


# 5.如何避免内存泄漏？
记住在适当的时间把timer设置成nil

# 6.关RunLoop什么关系？
timer 必须要加入runloop后才会被触发事件。只是用scheduledTimerWithTimeInterval的时候，系统自动添加到当前runloop了，不需要我们处理而已。

# 7.如何重新开始？
暂停timer：

```swift
-(void)pauseTimer{
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
}
```
继续timer：

```swift
-(void)resumeTimer{
    if (![self isValid]) {
     return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setFireDate:[NSDate date]];
}
```
重新计时：

## 8.Repeat中YES和NO有什么区别？
就是这个timer是不是会持续触发，设置YES以后要人为的invalidated，并设置为nil，设置成NO以后什么都不需要管了，系统会自动回收它。

## 9.[NSDate dateWithTimeIntervalSinceNow:0]和[NSDate date] 区别？
这两句话结果是一样的，只不过dateWithTimeIntervalSinceNow 可以指定距离当前时间之后多少秒

[NSDate date] 

```
Creates and returns a new date set to the current date and time.
```

[NSDate dateWithTimeIntervalSinceNow:0] 单位秒

```
Creates and returns an NSDate object set to a given number of seconds from the current date and time.
```

测试

```swift
NSDate *date1 = [NSDate date];
NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:0];
NSLog(@"%@,%@", date1.description,date2.description);
```
    
结果：
    
```
2017-06-21 06:08:21 +0000,
2017-06-21 06:08:21 +0000
```

## 10.setFireDate是干什么用的？
设置重复定时器触发的时间。设置成distantFuture就表示暂停了，具体设置这个值对下一个循环的影响很少人说。这个属于高级用法了。以后碰到了再补充一下吧。
```
The date at which the timer will fire.
```


如何串改时间字符串：
 NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:_createdAt];
   
    // 2.获得当前时间
    NSDate *now = [NSDate date];
   
    // 3.获得当前时间和微博发送时间的间隔（差多少秒）
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
   
    // 4.根据时间间隔算出合理的字符串
    if (delta < 60) { // 1分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 1天内
        return [NSString stringWithFormat:@"%.f小时前", delta/60/60];
    } else {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }

