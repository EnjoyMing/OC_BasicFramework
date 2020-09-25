//
//  SNHUD.h
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNHUD : NSObject
+ (void)initHUD;
+ (void)show;
+ (void)showString:(NSString *)string;
+ (void)showSuccess:(NSString *)string;
+ (void)showError:(NSString *)string;
+ (void)showProgress:(CGFloat)progress;
+ (void)hiddenWithBlock:(void(^)(void))block;
+ (void)hiddenWithDelay:(NSTimeInterval)delay Block:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
