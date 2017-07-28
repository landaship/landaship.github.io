# 前言

NSPredicate 谓词, 其实 NSPredicate 有时候完全可以被 [for...][if..else] 替换来实现功能, 但会造成代码不够优雅, 一堆的判断循环 有时一句 NSPredicate 便可实现. 今天作者就聊一聊谓词的使用.

# 一 NSPredicate 理解说明

 **NSPredicate**  : 中文直译谓词, 用来定义逻辑条件约束的搜索 或 内存中的过滤。

* 如同语法中的谓词, 如 [3 大于 2]中"大于"就是一个就是谓词. 简单点说 它是逻辑判断, 如同过滤器, 筛选你所需要的.

* NSPredicate 与 [for...][if..else] 功能有相同的地方, 单纯比较在手机上运行效率, 作者查阅过[度娘] [谷哥], 只简单说会提升效率, 但未找到具体数据说明, 作者便不引用了.

* 按作者个人理解 NSPredicate 如同专车服务,抵达目的地下车; [for...][if..else]便是公交服务, 你自己判断在哪一站下车. 所以NSPredicate有一定的便捷性, [for...][if..else]有更广的适用性.

# 二 NSPredicate 语法说明

//一般初始化

```swift
NSPredicate *pred = [NSPredicate predicateWithFormat:@"...", ...];
//与具体对象 进行筛选判断, 返回为BOOL值
[pred evaluateWithObject:...]
```

举例

```swift
//SELF支持小写, 代表正在被判断的对象自身
  NSNumber *num = @999;
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF = 999"];
  if ([pred evaluateWithObject:num]) {
      NSLog(@"%@", num);
  }
```
//结果打印

```
999
```
一般很少这么用, 因为这么写都不如 [if..else] 便捷, 下面就讲一下 NSPredicate 的用法.

## - 0. 集合类型方法说明


```
NSArray提供 : - (NSArray * )filteredArrayUsingPredicate:(NSPredicate *)predicate
```

```
NSMutableArray提供 : - (void)filterUsingPredicate:(NSPredicate *)predicate
```

```
NSSet提供 : - (NSSet *)filteredSetUsingPredicate:(NSPredicate *)predicate
```

```
NSMutableSet提供 : - (void)filterUsingPredicate:(NSPredicate *)predicate
```
## - 1. 比较运算符 (以数组举例说明)

先封装创建 Person 类 (应该不用上代码, 有需要留言, 作者补上)


```
//创建 Person 类数组
Person *p0 = [Person personName:@"ZhangSan" withAge:20 withSex:@"man"];
Person *p1 = [Person personName:@"HanMeiMei" withAge:12 withSex:@"woman"];
Person *p2 = [Person personName:@"LiLei" withAge:13 withSex:@"man"];
Person *p3 = [Person personName:@"XiaoHua" withAge:13 withSex:@"woman"];
NSArray *arr = @[p0, p1, p2, p3];
```
 
```
/** 比较运算符 */
NSPredicate *pred = [NSPredicate predicateWithFormat:@"age < %@", @20];
NSArray *resultArr = [arr filteredArrayUsingPredicate:pred];
NSLog(@"年龄小于20 :%@", resultArr);

pred = [NSPredicate predicateWithFormat:@"sex = 'woman' && age = 13"];
resultArr = [arr filteredArrayUsingPredicate:pred];
NSLog(@"年龄为13的女性 : %@", resultArr);

NSMutableArray *arrayM = [@[@20, @40, @50, @30, @60, @70] mutableCopy];
//  可以用 'BETWEEN {30, 50}' 代替 '>'
//  pred = [NSPredicate predicateWithFormat:@"SELF > 50"];
pred = [NSPredicate predicateWithFormat:@"SELF BETWEEN {30, 50}"];
[arrayM filterUsingPredicate:pred];
NSLog(@"可变数组过滤 : %@", arrayM);
```
    
//结果打印

```
年龄小于20 :(
   "HanMeiMei, 12, woman",
    "LiLei, 13, man",
    "XiaoHua, 13, woman"
)

年龄为13的女性 :(
   "XiaoHua, 13, woman"
)

可变数组过滤 : (
    40,
    50,
    30
)
```
## - 2. 字符串运算符

> BEGINSWITH：检查某个字符串是否以指定的字符串开头（如判断字符串是否以a开头：BEGINSWITH 'a'）
ENDSWITH：检查某个字符串是否以指定的字符串结尾
CONTAINS：检查某个字符串是否包含指定的字符串
LIKE：检查某个字符串是否匹配指定的字符串模板。其之后可以跟?代表一个字符和代表任意多个字符两个通配符。比如"name LIKE 'ac'"，这表示name的值中包含ac则返回YES；"name LIKE '?ac'"，表示name的第2、3个字符为ac时返回YES。
MATCHES：检查某个字符串是否匹配指定的正则表达式。虽然正则表达式的执行效率是最低的，但其功能是最强大的，也是我们最常用的。
注：字符串比较都是区分大小写和重音符号的。如：café和cafe是不一样的，Cafe和cafe也是不一样的。如果希望字符串比较运算不区分大小写和重音符号，请在这些运算符后使用[c]，[d]选项。其中[c]是不区分大小写，[d]是不区分重音符号，其写在字符串比较运算符之后，比如：name LIKE[cd] 'cafe'，那么不论name是cafe、Cafe还是café上面的表达式都会返回YES。


举例说明

```
//创建 Person 类数组
Person *p0 = [Person personName:@"ZhangSan" withAge:20 withSex:@"man"];
Person *p1 = [Person personName:@"HanMeiMei" withAge:12 withSex:@"woman"];
Person *p2 = [Person personName:@"LiLei" withAge:13 withSex:@"man"];
Person *p3 = [Person personName:@"XiaoHua" withAge:13 withSex:@"woman"];
NSArray *arr = @[p0, p1, p2, p3];
```
    
```
pred = [NSPredicate predicateWithFormat:@"name LIKE '??an*'"];  //名字中第三,四位是 an.
resultArr = [arr filteredArrayUsingPredicate:pred];
NSLog(@"1⃣️ : %@", resultArr);

pred = [NSPredicate predicateWithFormat:@"name LIKE '*an*'"];   //包含 字符串模板an.
resultArr = [arr filteredArrayUsingPredicate:pred];
NSLog(@"2⃣️ : %@", resultArr);

pred = [NSPredicate predicateWithFormat:@"NOT (name CONTAINS 'ua')"];   // 不包含 ua.
resultArr = [arr filteredArrayUsingPredicate:pred];
NSLog(@"3⃣️ : %@", resultArr);


pred = [NSPredicate predicateWithFormat:@"name LIKE '*ua*'"];
NSLog(@"判断返回bool值 : %d", [pred evaluateWithObject:p3]);

```
//结果打印

```
"1⃣️ : (
    "ZhangSan, 20, man"
)

2⃣️ : (
   "ZhangSan, 20, man",
   "HanMeiMei, 12, woman"
)

3⃣️ : (
    "ZhangSan, 20, man",
    "HanMeiMei, 12, woman",
    "LiLei, 13, man"
)

判断返回bool值 : 1
```

参考文章：http://www.jianshu.com/p/d4098bc9488d

