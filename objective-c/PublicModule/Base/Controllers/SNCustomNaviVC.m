//
//  SNCustomNaviVC.m
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNCustomNaviVC.h"

@interface SNCustomNaviVC ()
<
UIGestureRecognizerDelegate,
UINavigationBarDelegate,
UINavigationControllerDelegate
>
@end

@implementation SNCustomNaviVC

//TODO:================ 生命周期 ===============
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self subview_init];
}
//TODO:================ 功能实现 ===============
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn setTitle:@"<返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, 44, 44);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
//TODO:================ 私有方法 ===============
- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
}
//TODO:================ 代理实现 ===============
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
//TODO:================ UI初始化 ===============
- (void)subview_init {
    self.delegate = self;
    if ([NSObject respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.view.backgroundColor = [UIColor whiteColor];
}
//TODO:================ 懒 加 载 ===============

@end
