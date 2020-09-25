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
+(instancetype)share;
//传参接口Post
-(RACSignal *)rac_signalRequestWithPostUrl:(NSString *)urlStr
                                  withParam:(NSDictionary *)parameters
                              isShowLoading:(BOOL)isShow;
//传参接口Get
-(RACSignal *)rac_signalRequestWithGetUrl:(NSString *)urlStr
                                withParam:(NSDictionary *)parameters
                            isShowLoading:(BOOL)isShow;
@end

NS_ASSUME_NONNULL_END

