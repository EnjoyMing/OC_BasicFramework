//
//  SNHomePageVC.m
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNHomePageVC.h"

@interface SNHomePageVC ()

@end

@implementation SNHomePageVC
//TODO:================ 生命周期 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navi_bar_set];
    [self subview_init];
    [self network_request];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
//TODO:================ 网络请求 ===============
- (void)network_request {
    
}
//TODO:================ 功能实现 ===============
- (void)pushAction {
    [self.navigationController pushViewController:[SNCustomBaseVC new] animated:YES];
}
//TODO:================ 私有方法 ===============

//TODO:================ 代理实现 ===============

//TODO:================ UI初始化 ===============
- (void)subview_init {
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 300, 100, 50);
    [self.view addSubview:btn];
    [self.view addSubview:self.noDataView];
}
- (void)navi_bar_set {
    
}
//TODO:================ 懒 加 载 ===============

@end
