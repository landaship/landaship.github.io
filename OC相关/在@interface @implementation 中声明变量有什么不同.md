# 1.interface中的变量模式是privite的，在implementation里面的是protect的
2.privite的可以继承，implementation的不可以继承
3.privite的是成员变量，implementation是全局变量
@interface 中是成员变量

@implementation 是全局变量

作用域和存活区间的问题

比如你一个变量放在@interface 中，你申请一个实体时，变量存活周期跟你实体一样


在@implementation 中，因为是全局，所以一直存在

