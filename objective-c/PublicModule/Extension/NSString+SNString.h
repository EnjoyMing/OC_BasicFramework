//
//  NSString+SNString.h
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SNString)

/* MD5加密 */
- (NSString *)md5HexDigest;

/* base64Decoded */
- (NSString *)base64Decoded;

/* Base64 */
- (NSString *)base64;

/* 是否是邮箱格式 */
- (BOOL)isEmail;

/* 判断字符串为空 */
-(BOOL)isEmptyString;

/* 计算字符串宽高 */
- (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
