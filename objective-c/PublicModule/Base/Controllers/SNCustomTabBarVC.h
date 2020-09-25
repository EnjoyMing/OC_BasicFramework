//
//  SNCustomTabBarVC.h
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCustomTabBarVC : UITabBarController

@end

typedef void(^CustomTabBarBloack)(void);
@interface SNCustomTabBar : UITabBar
@property (nonatomic, copy) CustomTabBarBloack itemBlock;
@end

NS_ASSUME_NONNULL_END
