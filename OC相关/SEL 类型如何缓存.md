# 1.明确什么是selector（http://blog.csdn.net/fengsh998/article/details/8612969）
selector 可以理解成函数指针，用他相当于直接调用OC的函数，

用字典缓存，因为他是c类型的，所以不能直接用oc对象存储，思路是先讲他转换成NSString，然后再还原回来


NSString *selectorName = NSStringFromSelector(aSelector);

 NSString *selectorName = observerDic[@"aSelector"];
SEL aSelector = NSSelectorFromString(selectorName);

2.SEL 如何调用？会报警告！

因为SEL 1.参数不固定（不是这个原因，参数本身就是不固定的，这个selector特性决定的） 2.是否有返回值不确定，所以ARC环境下不能确定其是否需要retain，所以官方建议，在明确没有返回值的情况下使用：
[tmpObserver performSelectorOnMainThread:aSelector withObject:nil waitUntilDone:YES];

3.像通知那样，如果我想要多个参数的话怎么弄咧？他怎么知道我多个参数应该怎么传值。?
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test::::) name:@"test" object:nil];   test:::: 这个如果有多个一样的名字的会如何？子类中也有的话如何处理？

1.notifications 注册多个参数会崩溃，只能传两个参数的selector，参数一是NSNotification,参数二是发送通知的对象的实例
2 .这个和btn的selector还不一样，btn的selector可以任意传，第一个参数是btn对象，后续的都是TouchEvent事件

3.通知的addObserver事件中的最后一个参数Objc，是用于指定监听那个对象的Objec，这个Object要和你post的ObJect一致才会监听通知。


[[NSNotificationCenter defaultCenter] postNotificationName:@"1111" object:@"dddd"
];
    
    
    [[
NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ARCCCCC) name:@"1111" object:@"dddd"];

