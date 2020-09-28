//
//  SNGuideView.m
//  objective-c
//
//  Created by silence on 2020/9/27.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNGuideView.h"
#import "SNGuideImgCell.h"

@interface SNGuideView()
<
SNPagerViewDelegate,
SNPagerViewDataSource
>
@property (nonatomic, strong) SNPagerView    * pageView;
@property (nonatomic, strong) SNPagerControl * pageControl;
@property (nonatomic, strong) NSArray        * dataArray;
@property (nonatomic, strong) UIButton       * sureBtn;
@property (nonatomic, strong) UIButton       * skipBtn;
@end

@implementation SNGuideView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize_subview];
        [self reload_data];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"-----销毁--SNGuideView---");
}
#pragma mark ------------ 数据源 ------------
- (void)reload_data {
    self.dataArray = @[@"LaunchImg",
                       @"LaunchImg",
                       @"LaunchImg"];
    self.pageControl.numberOfPages = self.dataArray.count;
    [self.pageView reloadData];
}
#pragma mark ------------ 功能实现 ------------
+ (BOOL)showGuideView {
    SNGuideView * guideView = [[SNGuideView alloc]init];
    guideView.hidden = NO;
    guideView.frame = CGRectMake(0, 0, screen_w, screen_h);
    [[UIApplication sharedApplication].keyWindow addSubview:guideView];
    return YES;
}
- (void)deleteGuideView {
    [[NSUserDefaults standardUserDefaults] setValue:@"Lanch_Guide_view" forKey:Lanch_Guide_view];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.hidden = YES;
    [self removeFromSuperview];
}

#pragma mark ------------ 代理方法 ------------
//TODO:TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(SNPagerView *)pageView {
    return self.dataArray.count;
}

- (UICollectionViewCell *)pagerView:(SNPagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    SNGuideImgCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"SNGuideImgCell" forIndex:index];
    if (self.dataArray.count > index) {
        cell.faceImg.image = [UIImage imageNamed:self.dataArray[index]];
    }
    return cell;
}
- (void)pagerView:(SNPagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {

}
- (SNLayoutObject *)layoutForPagerView:(SNPagerView *)pageView {
    SNLayoutObject *layout = [[SNLayoutObject alloc]init];
    layout.itemSize = CGSizeMake(screen_w, screen_h);
    layout.itemSpacing = 0;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(SNPagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.pageControl.currentPage = toIndex;
    if (toIndex == self.dataArray.count-1) {
        self.sureBtn.hidden = NO;
        self.skipBtn.hidden = YES;
        self.pageControl.hidden = YES;
        self.pageView.autoScrollInterval = 0.0;
    }else{
        self.skipBtn.hidden = NO;
        self.sureBtn.hidden = YES;
        self.pageControl.hidden = NO;
        self.pageView.autoScrollInterval = 5.0;
    }
}

- (void)pagerViewDidScroll:(SNPagerView *)pageView {
    if (self.pageView.curIndex == 0) {//禁止右划
        static float newx = 0;
        static float oldx = 0;
        newx= pageView.collectionView.contentOffset.x;
        if (newx < oldx) {
            self.pageView.collectionView.scrollEnabled = NO;
            self.pageView.collectionView.scrollEnabled = YES;
        }
        oldx = newx;
    }else if (self.pageView.curIndex == self.dataArray.count-1){//禁止左划
        static float newx = 0;
        static float oldx = 0;
        newx= pageView.collectionView.contentOffset.x;
        if (newx > oldx) {
            self.pageView.collectionView.scrollEnabled = NO;
            self.pageView.collectionView.scrollEnabled = YES;
        }
        oldx = newx;
    }
}

#pragma mark ------------ 初始化 ------------
- (void)initialize_subview {
    [self addSubview:self.pageView];
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:self.pageControl];
    [self addSubview:self.sureBtn];
    [self bringSubviewToFront:self.sureBtn];
    [self addSubview:self.skipBtn];
    [self bringSubviewToFront:self.skipBtn];
}
#pragma mark ------------ 啦加载 ------------
- (SNPagerView *)pageView {
    if (!_pageView) {
        _pageView = [[SNPagerView alloc]init];
        _pageView.isInfiniteLoop = YES;
        _pageView.autoScrollInterval = 5.0;
        _pageView.dataSource = self;
        _pageView.delegate = self;
        _pageView.frame = CGRectMake(0, 0, screen_w, screen_h);
        [_pageView registerNib:[UINib nibWithNibName:@"SNGuideImgCell" bundle:nil] forCellWithReuseIdentifier:@"SNGuideImgCell"];
    }
    return _pageView;
}
- (SNPagerControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[SNPagerControl alloc]init];
        _pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
        _pageControl.pageIndicatorSize = CGSizeMake(12, 6);
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPage = 0;
        _pageControl.frame = CGRectMake(0, screen_h-50, screen_w, 30);
    }
    return _pageControl;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(screen_w*0.5-100, screen_h-100, 200, 50);
        _sureBtn.layer.cornerRadius = 10;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.backgroundColor = [UIColor whiteColor];
        _sureBtn.hidden = YES;
        [_sureBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(deleteGuideView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIButton *)skipBtn {
    if (!_skipBtn) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.frame = CGRectMake(screen_w-50, 25, 40, 40);
        _skipBtn.layer.cornerRadius = 20;
        _skipBtn.layer.masksToBounds = YES;
        _skipBtn.backgroundColor = [UIColor whiteColor];
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_skipBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(deleteGuideView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}


@end
