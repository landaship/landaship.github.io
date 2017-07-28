# 1.要不要用try catch
有好处就是别人可以很明确的知道你的是什么错
不好的地方是，如果代码比较长，给人视觉上有很大的凌乱感。

个人感觉：
* 如果你都知道错误是什么了，都是自己调用的，那就用返回值来做呗。
* 如果说是想要很多种返回结果，那么就用一种模型来返回呗。
* try   catch 只是用来捕捉异常情况而已，没有必要自己的接口也写成这样，try catch 适合那种有很多种错误结果的方式

# 2. try catch 可以避免程序崩溃，常用在处理字典数组等服务器返回的数据时。可以保证程序在运行时不会因为服务器字段改变导致前端崩溃。

# 3.try catch 用法

声明

```swift
-(void)testTry
{
    NSException *exception = [NSException exceptionWithName:@"这个时名字" reason:@"resonst34tsefgwt4r" userInfo:@{@"eee":@"ddd"}];
        
    @throw exception;
    return;
}
```

调用

```swift
@try {
   [self testTry];
} @catch (NSException *exception) {
   NSLog(@"++++++:%@,%@,%@", exception.name, exception.reason, exception.userInfo);
} @finally {
   NSLog(@"++++++finally");
}
```

输出：

```swift
2017-06-14 10:14:28.330 dfadfad[35746:840563] ++++++:这个时名字,resonst34tsefgwt4r,{
    eee = ddd;
}
```

参考：http://blog.csdn.net/totogo2010/article/details/7713793

