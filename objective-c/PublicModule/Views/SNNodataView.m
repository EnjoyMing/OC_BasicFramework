//
//  SNNodataView.m
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNNodataView.h"

@interface SNNodataView()
/*点击事件按钮*/
@property (nonatomic, strong) UIButton * tapBtn;
@end

@implementation SNNodataView
//TODO:================ 生命周期 ===============
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subview_init];
    }
    return self;
}
//TODO:================ 功能实现 ===============
- (void)onTapBtnAction {
    if (self.clickBlock != nil) {
        self.clickBlock();
    }
}
//TODO:================ 私有方法 ===============

//TODO:================ UI初始化 ===============
- (void)subview_init {
    [self addSubview:self.imgBtn];
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-50);
    }];
    [self addSubview:self.desLb];
    [self.desLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.top.equalTo(self.imgBtn.mas_bottom);
    }];
    [self addSubview:self.tapBtn];
    [self.tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.desLb);
        make.top.equalTo(self.imgBtn.mas_top).offset(8);
    }];
    [self bringSubviewToFront:self.tapBtn];
}

//TODO:================ 懒 加 载 ===============
//TODO:创建imgBtn
- (UIButton *)imgBtn {
    if (!_imgBtn){
        _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgBtn setImage:[UIImage imageNamed:@"sn_tabbar_middle_img"] forState:UIControlStateNormal];
    }
    return _imgBtn;
}
//TODO:创建desLb
- (UILabel *)desLb {
    if (!_desLb){
        _desLb = [[UILabel alloc] init];
        _desLb.text = @"暂无数据～";
        _desLb.textAlignment = NSTextAlignmentCenter;
        _desLb.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _desLb.numberOfLines = 0;
    }
    return _desLb;
}
//TODO:创建tapBtn
- (UIButton *)tapBtn {
    if (!_tapBtn){
        _tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tapBtn.backgroundColor = [UIColor clearColor];
        [_tapBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [_tapBtn addTarget:self action:@selector(onTapBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapBtn;
}
@end
