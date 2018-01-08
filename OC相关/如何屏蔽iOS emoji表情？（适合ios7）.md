# //屏蔽emoji表情输入
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
   if([[[UITextInputModecurrentInputMode]primaryLanguage]isEqualToString:@"emoji"]) {
       returnNO;
    }
   returnYES;
}

