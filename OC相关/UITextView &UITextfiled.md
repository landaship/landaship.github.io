# http://blog.sina.com.cn/s/blog_7018d3820101djut.html



一、键盘风格  

UIKit框架支持8种风格键盘。

1. typedef enum {  
2.     UIKeyboardTypeDefault,                // 默认键盘：支持所有字符   
3.     UIKeyboardTypeASCIICapable,           // 支持ASCII的默认键盘   
4.     UIKeyboardTypeNumbersAndPunctuation,  // 标准电话键盘，支持+*#等符号   
5.     UIKeyboardTypeURL,                    // URL键盘，有.com按钮；只支持URL字符   
6.     UIKeyboardTypeNumberPad,              //数字键盘   
7.     UIKeyboardTypePhonePad,               // 电话键盘   
8.     UIKeyboardTypeNamePhonePad,           // 电话键盘，也支持输入人名字   
9.     UIKeyboardTypeEmailAddress,           // 用于输入电子邮件地址的键盘   
10. } UIKeyboardType;  
用法用例：

textView.keyboardtype= UIKeyboardTypeNumberPad;

二、键盘外观

1. typedef enum {  
2.     UIKeyboardAppearanceDefault,    // 默认外观：浅灰色   
3.     UIKeyboardAppearanceAlert,      //深灰/石墨色   
4. } UIKeyboardAppearance;  
用法用例：

textView.keyboardAppearance=UIKeyboardAppearanceDefault;

三、回车键

1. typedef enum {  
2.     UIReturnKeyDefault, //默认：灰色按钮，标有Return
3.     UIReturnKeyGo,  //标有Go的蓝色按钮
4.     UIReturnKeyGoogle, //标有Google的蓝色按钮，用于搜索
5.     UIReturnKeyJoin, //标有Join的蓝色按钮
6.     UIReturnKeyNext, //标有Next的蓝色按钮
7.     UIReturnKeyRoute, //标有Route的蓝色按钮
8.     UIReturnKeySearch, //标有Search的蓝色按钮
9.     UIReturnKeySend, //标有Send的蓝色按钮
10.     UIReturnKeyYahoo, //标有Yahoo!的蓝色按钮，用于搜索
11.     UIReturnKeyDone, //标有Done的蓝色按钮
12.     UIReturnKeyEmergencyCall, //紧急呼叫按钮
13. } UIReturnKeyType; 
用法用例：

textView.returnKeyType=UIReturnKeyGo;

四、自动大写

1. typedef enum {  
2.     UITextAutocapitalizationTypeNone, //不自动大写   
3.     UITextAutocapitalizationTypeWords, //单词首字母大写   
4.     UITextAutocapitalizationTypeSentences, //句子首字母大写   
5.     UITextAutocapitalizationTypeAllCharacters, //所有字母大写   
6. } UITextAutocapitalizationType;  
用法用例：


textField.autocapitalizationType = UITextAutocapitalizationTypeWords;

五、自动更正

1. typedef enum {  
2.     UITextAutocorrectionTypeDefault,//默认   
3.     UITextAutocorrectionTypeNo,//不自动更正   
4.     UITextAutocorrectionTypeYes,//自动更正   
5. } UITextAutocorrectionType;  
用法用例：


textField.autocorrectionType = UITextAutocorrectionTypeYes;

六、安全文本输入

textView.secureTextEntry=YES;

开启安全输入主要是用于密码或一些私人数据的输入，此时会禁用自动更正和自此缓存。



统计字符和响应RETURN键

统计字符：

```swift

1、UITextView

- (void)textViewDidChange:(UITextView *)textView
{
    int count = [textView.text length];
    //这里的count就是字符个数了
}
```
2、UITextField

方法一：

自己先为UITextField的Editing Changed事件添加一个响应方法


```swift
-(IBAction)valuechange//m_TextField是UITextField的一个IBOutlet
{
     int count = [m_TextField.text length];
     //count就是当前的字符个数

    //下边是将字符限制在140以内
    if ([m_TextField.text length]>140) {
        [m_TextField setText:[m_TextField.text substringToIndex:140]];//多出140时，只取前140个字符
    }
}
```
方法二：


```swift
在代理方法：
-(BOOL)textField:(UITextField *)textFieldshouldChangeCharactersInRange:(NSRange)rangereplacementString:(NSString*)string
判断range.length的值来判断输入的是回格还是其它字符
```
 

响应Return键：

1、UITextView

//代理方法

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        return NO;
    }else {
        if ([textView.text length] < 140) {//判断字符个数
            return YES;
        }  
    }
    return NO;
}

2、UITextField

这个直接有代理方法哈

- (BOOL)textFieldShouldReturn:(UITextField *)textField



UITextField进入编辑状态获得焦点 becomeFirstResponder


 关闭键盘 resignFirstResponder 


键盘监听事件处理：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度

{
   
 CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue
];
   
 CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil
];
   
 return keyboardEndingFrame.size.height
;
}

-(
void)keyboardWillAppear:(NSNotification 
*)notification
{
   
 CGFloat keyboardY = [self keyboardEndingFrameHeight:[notification userInfo
]];
   
 self.view.transform = CGAffineTransformMakeTranslation(0
, -keyboardY);
}

-(
void)keyboardWillDisappear:(NSNotification 
*)notification
{
   
 self.view.transform = CGAffineTransformMakeTranslation(0, 0
);
}

-(
void
)OnScreenTap
{
    [
self.textInput resignFirstResponder];


取消UITextField第一响应的几种方法   

1.[self.view endEditing:YES];
2.[self.textField  resignFirstResponder]; 
}

