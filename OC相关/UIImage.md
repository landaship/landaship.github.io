# 1.如何动态改变UIButton的图标的颜色，使其根据主题变色？
> 场景：

```swift
-(void)build
{
    self.view.backgroundColor = [UIColor blackColor];
    MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(55, 55, 100, 50)];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    UIImage *buttonImage = [UIImage imageNamed:@"dizhi"];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    [self.view addSubview:button];
}
```

> 解决办法：新建一个UIImage的category，添加如下方法

```
- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
```

> 使用：

```
[button setImage:[buttonImage imageWithColor:[UIColor blueColor]]forState:UIControlStateNormal];
```

> 原理

