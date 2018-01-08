# Tab bar的高度固定48这个高度

添加tabbar的时候注意要设置        video.tabBarItem.title=@"我是视频君";
        video.tabBarItem.image=[UIImageimageNamed:@"tab_buddy_nor”];
否则加载出来的table看不到第二个以后的item

方法：
        // 添加viewcontroller
        PhotosViewController *photos = [[PhotosViewController alloc]init];
        self.tabBarItem.image=[UIImage imageNamed:@"tab_recent_nor"];
        self.tabBarItem.badgeValue=@"123";
       
        VideoViewController *video = [[VideoViewController alloc]init];
        video.tabBarItem.title=@"我是视频君";
        video.tabBarItem.image=[UIImage imageNamed:@"tab_buddy_nor"];

        self.viewControllers = @[photos, video];





每一个viewController都有一个tabBarItem




