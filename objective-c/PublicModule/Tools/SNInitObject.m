//
//  SNInitObject.m
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNInitObject.h"

static SNInitObject * shared;

@implementation SNInitObject

+ (instancetype) share {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        shared = [[SNInitObject alloc]init];
    });
    return shared;
}
-(void)init_custom {
    //控制整个功能是否启用
    [IQKeyboardManager sharedManager].enable = YES;
    //启用手势触摸:控制点击背景是否收起键盘。
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //是否显示提示文字
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义,(使用TextField的tintColor属性IQToolbar，否则色调的颜色是黑色 )
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
}
//TODO:初始化动态启动图
-(void)setupLaunchImage:(UIWindow *)window {
    UIViewController * launchSB = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"launchScreen"];
    UIView * launchView = launchSB.view;
    [window addSubview:launchView];
    // 动画效果
    [UIView animateWithDuration:1.5 animations:^{
        launchView.alpha = 0.0;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}
@end
