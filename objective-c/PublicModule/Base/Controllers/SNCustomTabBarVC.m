//
//  SNCustomTabBarVC.m
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNCustomTabBarVC.h"

@interface SNCustomTabBarVC ()
@property (nonatomic, strong) SNCustomTabBar * customTabBar;
@end

@implementation SNCustomTabBarVC

//TODO:================ 生命周期 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    [self subview_init];
    [self addTabBarVC];
}
//TODO:================ 私有方法 ===============
- (void)addTabBarVC {
    //生成文件的存储路径
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"TabBarItemList" ofType:@"plist"];
    //读取属性列表文件，并转化为可变字典对象
    NSArray * data = [NSArray arrayWithContentsOfFile:plistPath];
    for (NSDictionary * dict in data) {
        NSString * vcName = dict[@"className"];
        NSString * normallImg = dict[@"normallImg"];
        NSString * selectedImg = dict[@"selectedImg"];
        NSString * titleS = dict[@"titleName"];
        Class childVcClass = NSClassFromString(vcName);
        if (!childVcClass) {
            NSLog(@"没有获取到对应的class");
            return;
        }
        SNCustomBaseVC *vc = [[childVcClass alloc] init];
        UIImage *norImg = [UIImage imageNamed:normallImg];
        UIImage *selImg = [UIImage imageNamed:selectedImg];
        //适配iOS7以后的版本，iOS7以前默认渲染保持图片原样。
        if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
            norImg = [norImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selImg = [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        vc.tabBarItem.title = titleS;
        vc.tabBarItem.image = norImg;
        vc.tabBarItem.selectedImage = selImg;
        vc.title = titleS;
        SNCustomNaviVC * nav = [[SNCustomNaviVC alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    }
    [self setValue:self.customTabBar forKeyPath:@"tabBar"];
    weak_self(self);
    self.customTabBar.itemBlock = ^{
        strong_self(self);
        self.selectedIndex = 2;
    };
}
//TODO:================ UI初始化 ===============
- (void)subview_init {
    self.tabBar.translucent = NO;
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    /* 设置所有UITabBarItem的文字属性 */
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
//TODO:================ 懒 加 载 ===============
//TODO:创建tabbar
- (SNCustomTabBar *)customTabBar {
    if (!_customTabBar){
        _customTabBar = [[SNCustomTabBar alloc] init];
    }
    return _customTabBar;
}
@end




//TODO:自定义TabBar
@interface SNCustomTabBar()
/* 中间的按钮 */
@property (nonatomic, weak) UIButton *middleButton;
@end

@implementation SNCustomTabBar
//TODO:================ 初始化 ===============
- (void)layoutSubviews {//布局子控件
    [super layoutSubviews];
    /* 设置所有UITabBarButton的frame */
    // 按钮的尺寸
    CGFloat buttonW = self.frame.size.width / 5;
    /* 设置中间的发布按钮的frame */
    self.middleButton.frame = CGRectMake(self.frame.size.width * 0.5-buttonW*0.5, 0, buttonW, buttonW);
}
//TODO:================ 功能实现 ===============
- (void)publishClick {
    if (self.itemBlock != nil) {
        self.itemBlock();
    }
}
//TODO:================ 懒 加 载 ===============
- (UIButton *)middleButton {
    if (!_middleButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:[UIImage imageNamed:@"sn_tabbar_middle_img"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"sn_tabbar_middle_img"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
        [self addSubview:btn];
        _middleButton = btn;
    }
    return _middleButton;
}
@end
