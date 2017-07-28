# 1.为什么要加入commonRunloop？是为了防止子线程不会自动启用么？

```
[_socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
``` 
# 2. dispatch_main_async_safe 保证任务都在主线程中执行
    
```
/**
*  异步回调主线程
*/
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}
```

