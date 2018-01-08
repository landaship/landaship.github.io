# #define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


// @#  这个是字符化操作符号，就是把这个对象的变量名以字符串的形式输出来
#define YLog(_var) ({ NSString *name = @#_var; NSLog(@"%@: %@ -> %p : %@ ", name, [_var class], _var, _var); })


//__VA_ARGS__ ##__VA_ARGS_ _两个是一样的，后面这个可以防止逗号被编译的情况 这个是取变量的值，你输入多少个，后面可以按顺序一直取,传少了，就看你有没有用到多个,如果用到了__VA_ARGS__，那么就必须传两个以上的入参
#define SSS(FORMAT, ...) NSLog(@"%@%@%@",FORMAT,##__VA_ARGS__,##__VA_ARGS__);
#define SS(FORMAT, ...) NSLog(@"%@",FORMAT);

