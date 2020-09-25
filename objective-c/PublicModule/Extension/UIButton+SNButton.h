//
//  UIButton+SNButton.h
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionBlock)(UIButton* button);

@interface UIButton (SNButton)
@property (nonatomic, copy) ActionBlock actionBlock;
/*
 button 添加点击block事件
 @param action 点击事件回调
 */
- (void)addAction:(ActionBlock)action;
 
/*
 button 添加点击block事件
 @param controlEvents 点击的方式
 @param action 点击事件回调
 */
- (void)addControlEvents:(UIControlEvents)controlEvents Action:(ActionBlock)action;

@end

NS_ASSUME_NONNULL_END
