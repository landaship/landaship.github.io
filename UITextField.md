# 1.设置左右view
        _textField = [[TKTextField alloc]initWithFrame:CGRectMake(20, KMargin, self.width-2*20, 40)];
        _textField.placeholder = @"证券代码";
        _textField.tkKeyBoardType = TKKeyBoardTypeStock;
        
        _textField.rightView = self.searchBtn;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        _textField.leftView = paddingView;
        _textField.leftViewMode = UITextFieldViewModeAlways;


## 禁止编辑
userInteractionEnabled


设置图片  

CGFloatphoneNumFieldX =CGRectGetMinX(_segmentController.frame);
   CGFloatphoneNumFieldY= kMargin;
   _phoneNumField_1= [[UITextFieldalloc]initWithFrame:CGRectMake(phoneNumFieldX,phoneNumFieldY,kSegmentControllerWidth,kTextFieldHight)];
   _phoneNumField_1.placeholder=@"请输入手机号码";
   _phoneNumField_1.layer.borderColor= [UIColorwhiteColor].CGColor;
   _phoneNumField_1.layer.borderWidth=1;
   _phoneNumField_1.layer.cornerRadius=6.0;
   _phoneNumField_1.delegate=self;
   _phoneNumField_1.keyboardType=UIKeyboardTypeNumberPad;
   UIImageView*phoneImageView = [[UIImageViewalloc]initWithImage:[UIImageimageNamed:@"iphone_mobile"]];
    phoneImageView.frame=CGRectMake(2,0,24,24);
   _phoneNumField_1.leftView= phoneImageView;
    _phoneNumField_1.leftViewMode=UITextFieldViewModeAlways;
    [_scrollViewaddSubview:_phoneNumField_1];


