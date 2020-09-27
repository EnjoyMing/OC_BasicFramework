//
//  SNNetworking.h
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNNetworking : NSObject

/* 创建单利对象 */
+(instancetype)share;

/* 传参接口POST
 * @param urlStr 网络请求地址
 * @param parameters 网络请求参数
 * @param isShow 是否展示菊花
*/
-(RACSignal *)rac_signalRequestWithPostUrl:(NSString *)urlStr
                                  withParam:(NSDictionary *)parameters
                              isShowLoading:(BOOL)isShow;

/* 传参接口GET
 * @param urlStr 网络请求地址
 * @param parameters 网络请求参数
 * @param isShow 是否展示菊花
 */
-(RACSignal *)rac_signalRequestWithGetUrl:(NSString *)urlStr
                                withParam:(NSDictionary *)parameters
                            isShowLoading:(BOOL)isShow;
@end

NS_ASSUME_NONNULL_END

