#     // 字符串替换
    NSString *test = @"1.0万";
    test = [test stringByReplacingOccurrencesOfString:@".0" withString:@""];
    NSLog(@"test:%@", test);



何截取html里的url
    int begin = [source rangeOfString:@">"].location + 1;
    int end = [source rangeOfString:@"</"].location;
   
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(begin, end - begin)]];

