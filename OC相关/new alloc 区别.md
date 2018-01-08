# 1.alloc 效率更高，因为alloc init 可以把初始化的变量都放到一个defaultZone里
2.alloc 能够调用initXXX方法，而new 只能隐式调用init方法

http://mobile.51cto.com/hot-404891.htm

