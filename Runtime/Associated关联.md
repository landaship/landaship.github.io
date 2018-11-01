# 关联对象

函数定义

http://blog.leichunfeng.com/blog/2015/06/26/objective-c-associated-objects-implementation-principle/#jtss-tsina
雷纯锋 这位iOS开发者分析很透彻

## 1.方法集

```
void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
设置关联，用于给对象添加关联对象，传入 nil 则可以移除已有的关联对象；

id objc_getAssociatedObject(id object, const void *key);
获取关联对象

void objc_removeAssociatedObjects(id object);
移除关联，这个会移除跟类实例关联的所有对象，如果要移除某一个，则需要objc_setAssociatedObject 设置为nil
```

## 2.使用场景
1.Category 添加属性
2.待开发

## 4 参数解析

四个参数：
> 1.object

鼓

> 2.key
 
作用：唯一标识关联对象的一个常量
要求：**一个对象级别** 中的 **唯一** 常量
使用：

```
1. 声明 static char kAssociatedObjectKey = '0'; 
    使用 &kAssociatedObjectKey 作为 key 值;
2. 声明 static void *kAssociatedObjectKey = &kAssociatedObjectKey; 
    使用 kAssociatedObjectKey 作为 key 值；
3. 用 selector ，使用 getter 方法的名称作为 key 值。
    @selector(name)  **推荐使用，省掉命名**
4. 发现用static const NSStrig *identify = @"0";
    使用identify 也可以，没解释明白
```
> 3. value

要关联的对象 


> 4. policy

关联策略	等价属性	说明
OBJC_ASSOCIATION_ASSIGN	@property (assign) or @property (unsafe_unretained)	弱引用关联对象
OBJC_ASSOCIATION_RETAIN_NONATOMIC	@property (strong, nonatomic)	强引用关联对象，且为非原子操作
OBJC_ASSOCIATION_COPY_NONATOMIC	@property (copy, nonatomic)	复制关联对象，且为非原子操作
OBJC_ASSOCIATION_RETAIN	@property (strong, atomic)	强引用关联对象，且为原子操作
OBJC_ASSOCIATION_COPY	@property (copy, atomic)	复制关联对象，且为原子操作

## 5.使用

```
objc_setAssociatedObject(self, &associatedButtonkey, blcok, OBJC_ASSOCIATION_COPY_NONATOMIC);
  
//通过 objc_getAssociatedObject获取关联对象
objc_getAssociatedObject(self, &associatedButtonkey);

//使用函数objc_removeAssociatedObjects可以断开所有关联。通常情况下不建议使用这个函数，因为他会断开所有关联。只有在需要把对象恢复到“原始状态”的时候才会使用这个函数。

断开关联是使用objc_setAssociatedObject函数，传入nil值即可。
objc_setAssociatedObject(self, &associatedButtonkey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
```

## 6.总结
Demo详见笔记Demo中的“属性关联”章节

关联对象：AssociatedTestViewController
被关联对象：NSString
1.关联对象和被关联对象并不是一起存储的，也就是说AssociatedTestViewController实例还在但是被关联对象却可能被释放了，他们之间的关系是用Has表来记录的，也就是说：关联对象通过Has表只记录了被关联对象的地址，实际是否持有还得看关联的策略。
2.正常情况下，要用OBJC_ASSOCIATION_RETAIN_NONATOMIC的关联策略，否则就会出现第一种情况
3.OBJC_ASSOCIATION_RETAIN_NONATOMIC 他是怎么去持有这个被关联对象的？
4.对象所关联的对象是在这个对象（AssociatedTestViewController）被释放的时候调用_object_remove_assocations来解除关联的

