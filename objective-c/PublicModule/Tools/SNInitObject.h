//
//  SNInitObject.h
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNInitObject : NSObject

//TODO:创建单列对象
+(instancetype)share;

//TODO:初始化裤
-(void)init_custom;

//TODO:现实引导页还是启动页
- (void)checkGuideViewOrLaunchView;

//TODO:初始化动态启动图
-(void)setupLaunchImage;

//TODO:初始化根视图
- (void)init_rootController;

@end

NS_ASSUME_NONNULL_END
