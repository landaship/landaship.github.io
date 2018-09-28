# 1.what is Blocks?
     带有自动变量的匿名函数。
     解析：
          自动变量：变量分为很多种，静态全局变量，静态局部变量，函数参数，局部变量（为什么称之为自动变量），全局变量

# 2.block 为何用copy属性
// block 得用copy属性,block的retain行为默认是用copy的行为实现的，因为block变量默认是声明为栈变量的，为了能够在block的声明域外使用，所以要把block拷贝（copy）到堆，所以说为了block属性声明和实际的操作一致，最好声明为copy。
@property (nonatomic, copy) TKAnyChatToolsBlock block;    // 结果处理block

# 3.局部变量为何必须加__block
参考：https://blog.csdn.net/u014600626/article/details/78697535
局部变量被block引用的都是值，而不是变量的地址，所以你在block里改动该值的时候对外部是一点影响都没有，所以Clang就直接给你报错了。
加上__block 以后block会把该局部变量从栈往堆里面考，拷贝了该对象的内存地址，但是随之而来的是，这个局部变量将不是局部的了，他会被block持有。

# typeof 的理解
参考：https://blog.csdn.net/qq_24901135/article/details/46708035
__block typeof(self) bself = self 分解：typeof(self) 返回对象类型，bself 相当于重新声明了一个变量，用block修饰的，指向了self，结果就是生成了一个self的弱引用
__weak typeof (_test)BBSelf = _test;  所以这个就是_test的弱引用





