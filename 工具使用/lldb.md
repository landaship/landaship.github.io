# 1.动态监听某个变量是否被修改值
用法：

```
(lldb) watchpoint set v string_weak_assign
```
其中：string_weak_assign 为你要观察的变量

```
Watchpoint created: Watchpoint 1: addr = 0x1042b3458 size = 8 state = enabled type = w
    declare @ '/Users/louis/Downloads/AssociatedObjects-master/AssociatedObjects/ViewController.m:15'
    watchpoint spec = 'string_weak_assign'
    new value: 0x00006000021528a0
```

然后继续执行程序，在string_weak_assign被改变的时候会触发hit事件

```
Watchpoint 1 hit:
old value: 0x00006000021528a0
new value: 0x0000000000000000
```


