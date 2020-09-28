//
//  SNUserInfo.h
//  objective-c
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNUserInfo : NSObject

@property (nonatomic, copy) NSString * uid;//id
@property (nonatomic, copy) NSString * nickName;//昵称
@property (nonatomic, copy) NSString * headImg;//头像
@property (nonatomic, copy) NSString * birthday;//生日
@property (nonatomic, copy) NSString * email;//邮件
@property (nonatomic, copy) NSString * phoneNum;//电话
@property (nonatomic, copy) NSNumber * sex;//性别

/*登录状态*/
@property (nonatomic, assign) BOOL loginStatus;

/*创建单利*/
+ (instancetype)share;

/*创建单利*/
+ (void)configInfo:(NSDictionary *)info;

/*退出登录*/
+ (void)loginOut;

@end

NS_ASSUME_NONNULL_END
