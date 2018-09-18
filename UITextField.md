# 1.设置左右view

```
_textField = [[TKTextField alloc]initWithFrame:CGRectMake(20, KMargin, self.width-2*20, 40)];
_textField.placeholder = @"证券代码";
_textField.tkKeyBoardType = TKKeyBoardTypeStock;
   
_textField.rightView = self.searchBtn;
_textField.rightViewMode = UITextFieldViewModeAlways;
   
UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
_textField.leftView = paddingView;
_textField.leftViewMode = UITextFieldViewModeAlways;
```


# 2.禁止编辑
userInteractionEnabled

# 3.限制选择、放大镜
注意一点，必须在textField的子类实现才有作用
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
 不想要的都return NO
}




