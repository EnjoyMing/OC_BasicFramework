//
//  SNCustomBaseVC.m
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNCustomBaseVC.h"
#import "SNHomePageVC.h"

@interface SNCustomBaseVC ()

@end

@implementation SNCustomBaseVC
//TODO:================ 生命周期 ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    [self subview_init];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray * vcArray = @[@([self isKindOfClass:NSClassFromString(@"SNHomePageVC")])];
    if ([vcArray containsObject:@(YES)]) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        return;
    }
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)dealloc {
    NSLog(@">>>>>>>>>>%@ 已经释放了<<<<<<<<<<",[NSStringFromClass(self.class) componentsSeparatedByString:@"."].lastObject);
}
//TODO:================ 功能实现 ===============

//TODO:================ 私有方法 ===============

//TODO:================ 代理实现 ===============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.0001)];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.0001)];
}
//TODO:================ UI初始化 ===============
- (void)subview_init {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}
//TODO:================ 懒 加 载 ===============
//TODO:创建tableView
- (UITableView *)tableView {
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _tableView;
}
//TODO:创建arr
- (NSMutableArray *)dataArray {
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
//TODO:创建nodataView
- (SNNodataView *)noDataView {
    if (!_noDataView){
        _noDataView = [[SNNodataView alloc] initWithFrame:CGRectMake(0, 0, screen_w, screen_h)];
    }
    return _noDataView;
}
@end
