//
//  SNInitObject.m
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNInitObject.h"

@interface SNInitObject()
{
    dispatch_source_t _timer;
    UIButton * _skipBtn;//跳过和倒计时按钮
    UIImageView * _faceImg;//启动图
    UIView * _tempView;//跳过和倒计时按钮背景视图
    UIViewController * _launchSB;//启动控制器
}
@property (nonatomic, copy) NSString * link_url;
@end

static SNInitObject * shared;

@implementation SNInitObject

+ (instancetype) share {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        shared = [[SNInitObject alloc]init];
    });
    return shared;
}
- (void)dealloc {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    _timer = nil;
}
#pragma mark ========== 全局初始化部分 ==========
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


#pragma mark ========== 动态启动图部分 ==========
//TODO:初始化动态启动图
-(void)setupLaunchImage:(UIWindow *)window {
    _launchSB = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"launchScreen"];
    UIView * launchView = _launchSB.view;
    _skipBtn = [launchView viewWithTag:2022];
    _faceImg = [launchView viewWithTag:2020];
    _tempView = [launchView viewWithTag:2021];
    __weak typeof(self) weakSelf = self;
    [_skipBtn addAction:^(UIButton * _Nonnull button) {
        [weakSelf deleteLaunchView];
    }];
    _tempView.layer.masksToBounds = YES;
    _tempView.layer.cornerRadius = 5.0;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onImgTapAction)];
    [_faceImg addGestureRecognizer:tap];
    [window addSubview:launchView];
    [self startTimer];
}
-(void)deleteLaunchView {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    _timer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        // 动画效果
        [UIView animateWithDuration:1.5 animations:^{
            self->_launchSB.view.alpha = 0.0;
            self->_launchSB.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0);
        } completion:^(BOOL finished) {
            [self->_launchSB.view removeFromSuperview];
        }];
    });
    
}
-(void)startTimer {
    NSDate *oldDate = [NSDate date];
    // 倒计时时间
    __block NSInteger timeOut = 5.0;
    [_skipBtn setTitle:@"跳过 | 05s" forState:UIControlStateNormal];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            [weakSelf deleteLaunchView];
        } else {
            NSDate *newDate = [NSDate date];
            NSTimeInterval timeInterva = [newDate timeIntervalSinceDate:oldDate];
            int seconds2 = (6.0 - timeInterva);
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d",seconds2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_skipBtn setTitle:[NSString stringWithFormat:@"跳过 | %@s", timeStr] forState:UIControlStateNormal];
            });
            //bug 解决
            if (seconds2 <= 1) {
                timeOut = 1;
            }
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
//点击图片跳转
- (void)onImgTapAction {
    if ([self.link_url isEmptyString]) {
        return;
    }
    if (![self.link_url containsString:@"http"]) {
        return;
    }
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:self.link_url];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                NSLog(@"Open %@: %d",self.link_url,success);
            }];
            return;
        }
        if ([application respondsToSelector:@selector(openURL:)]) {
            BOOL success = [application openURL:URL];
            NSLog(@"Open %@: %d",self.link_url,success);
        }
    }
}
@end
