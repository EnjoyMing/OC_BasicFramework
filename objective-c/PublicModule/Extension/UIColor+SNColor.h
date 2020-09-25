//
//  UIColor+SNColor.h
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SNColor)
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
