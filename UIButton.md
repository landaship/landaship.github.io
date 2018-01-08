# 当图片是disapble的时候会自动减淡图片颜色，这个时候需要：   btn.enabled = NO;  // 取消按钮响应事件
    btn.adjustsImageWhenDisabled = NO;  // 防止按下的时候按钮变颜色

参考资料：http://blog.csdn.net/u010850094/article/details/52181061
uibutton的图片和label的布局
btn.imageEdgeInsets = UIEdgeInsetsMake(0.0,-20.0, 0.0, - btn.titleLabel.width-10.0f); btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, btn.imageView.width-10.0f, 0.0, 0.0);



Button正常情况下图片在左边，文字在右边
想翻过来怎么处理？

 [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -backBtn.imageView.image.size.width+15, 0, backBtn.imageView.image.size.width-15)];
 [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, backBtn.titleLabel.bounds.size.width + 10, 0, -backBtn.titleLabel.bounds.size.width-10)];


思路：文字和图片等Inset互换


