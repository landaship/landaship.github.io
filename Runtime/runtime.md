# 1.交换方法

通过从写它的systemFontOfSize 方法，进行方法替换，把size改小做适配，这个不能修改xib中的字体，只有用了systemFontOfSize方法的才会生效

头文件

```
//
//  UIFont+adapt.h
//  TKApp
//
//  Created by 叶璐 on 18/2/17.
//  Copyright © 2017年 liubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)

// 屏幕适配是按照6p来做，所以6的字号减一，如6p是17号字体，6是16号
#define IPHONE6_INCREMENT 1

// 屏幕适配是按照6p来做，所以5S字号要减二，如6p是17号字体，6是15号
#define IPHONE5S_INCREMENT 2

@interface UIFont (adapt)

+(UIFont *)adjustFont:(CGFloat)fontSize;

@end

```

m文件

```

#import "UIFont+adapt.h"

@implementation UIFont (adapt)

+(void)load{
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);
}

+(UIFont *)adjustFont:(CGFloat)fontSize{
    UIFont *newFont=nil;
    if (IS_IPHONE_6){
        newFont = [UIFont adjustFont:fontSize - IPHONE6_INCREMENT];
    }else if (IS_IPHONE_6_PLUS){
        newFont = [UIFont adjustFont:fontSize];
    }else{
        newFont = [UIFont adjustFont:fontSize - IPHONE5S_INCREMENT];
    }
    return newFont;
}

@end

```


ui类成员属性的方法




#import <objc/runtime.h>

可以参考MJExtention
![](media/15153907005281.jpg)


# 2.Method Swizzling （方法混合、方法交换）
作用：动态替换已有的类方法
解析：
https://www.jianshu.com/p/ff19c04b34d0

class_getInstanceMethod得到类的实例方法
class_getClassMethod得到类的类方法

# 3.AOP  VS OOP
* AOP: (Aspect Oriented Programming) 面向切面编程。

> AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率。主要的功能是：日志记录，性能统计，安全控制，事务处理，异常处理等等。
> 最常用的AOP应用在数据库连接以及事务处理上。
> 实现模式可能为：代理模式+工厂模式
> 总之，AOP可以通过预编译方式和运行期动态代理实现在不修改源代码的情况下给程序动态统一添加功能的一种技术，把散落在程序中的公共部分提取出来，做成切面类，这样的好处在于，代码的可重用，一旦涉及到该功能的需求发生变化，只要修改该代码就行，否则，你要到处修改，如果只要修改1、2处那还可以接受，万一有1000处呢。

简单理解：AOP用于抽象一个独立的业务，好像有点像面向过程 



* OOP:面向对象编程

> 针对业务处理过程的实体及其属性和行为进行抽象封装，以获得更加清晰高效的逻辑单元划分。 
 
参考：
https://www.cnblogs.com/supersnow/p/4679453.html

# 4.IMP（implementation）：实现
https://www.jianshu.com/p/84d1771e9792

## 5.addSubview和insertSubview 区别
insertSubView可以控制将view添加到指定的层 
addsubview时都是在最上面面添加 






