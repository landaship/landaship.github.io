# http://www.open-open.com/lib/view/open1438053045972.html
直接调用引发的问题：简单的说就是你直接调用layoutSubViews 之后如果你的UI复杂，你的view的frame改变会触发这个layoutsubViews，你的滚动什么的都会触发一次，然后这些事件系统是帮你弄到一个View Drawing Cycle里头，然后在一个runloop 统一去调用，如果你自己调用了，会导致效率不高，但是我自己测试发现我手动调用一次以后系统还会再调用一次，如果view复杂一些可能就会一直调用吧。（目前还没有测试出来）
http://ios.jobbole.com/84836/

setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。而setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。
layoutSubviews在以下情况下会被调用：
1、init初始化不会触发layoutSubviews
2、addSubview会触发layoutSubviews
3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
4、滚动一个UIScrollView会触发layoutSubviews
5、旋转Screen会触发父UIView上的layoutSubviews事件
6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件

- (CGSize)sizeThatFits:(CGSize)size
- (void)sizeToFit
——————-
- (void)layoutSubviews
- (void)layoutIfNeeded
- (void)setNeedsLayout
——————–
- (void)setNeedsDisplay
- (void)drawRect
layoutSubviews在以下情况下会被调用：
1、init初始化不会触发layoutSubviews
   但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
2、addSubview会触发layoutSubviews
3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
4、滚动一个UIScrollView会触发layoutSubviews
5、旋转Screen会触发父UIView上的layoutSubviews事件
6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
在苹果的官方文档中强调:
//当autoresizing 属性达不到你想要的  你就需要重写该方法
      You should override this method only if the autoresizing behaviors of the subviews do not offer the behavior you want.
 layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。
反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写。
 刷新子对象布局
-layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写

-setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用

-layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局
在视图第一次显示之前，标记总是“需要刷新”的，可以直接调用[view layoutIfNeeded]
重绘
-drawRect:(CGRect)rect方法：重写此方法，执行重绘任务

-setNeedsDisplay方法：标记为需要重绘，异步调用drawRect

-setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘
 
sizeToFit会自动调用sizeThatFits方法；
sizeToFit不应该在子类中被重写，应该重写sizeThatFits
sizeThatFits传入的参数是receiver当前的size，返回一个适合的size
sizeToFit可以被手动直接调用
sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
———————————-
layoutSubviews对subviews重新布局
layoutSubviews方法调用先于drawRect
setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的
 layoutIfNeeded遍历的不是superview链，应该是subviews链
drawRect是对receiver的重绘，能获得context
setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iPhone device的刷新频率是60hz，也就是1/60秒后重绘

