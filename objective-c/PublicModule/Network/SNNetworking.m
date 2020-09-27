//
//  SNNetworking.m
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNNetworking.h"

static SNNetworking * shared;

@implementation SNNetworking

+ (instancetype)share {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        shared = [[SNNetworking alloc]init];
    });
    return shared;
}

//基础数据请求Post
-(RACCommand *)rac_commandWithPostRequestUrl:(NSString *)urlStr
                               isShowLoading:(BOOL)isShow {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *parameters) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            if (isShow) {
                [SNHUD show];
            }
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSLog(@"\n====请求接口===\n == %@\n====请求参数====\n=%@\n",urlStr,parameters);
            [manager POST:urlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isShow) {
                    [SNHUD hiddenWithBlock:^{}];
                }
                NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
                if (jsondic != nil && ![jsondic isKindOfClass:[NSNull class]]) {
                    [subscriber sendNext:jsondic];
                    [subscriber sendCompleted];
                }else{
                    if (isShow) {
                        [SNHUD showError:@"非json格式数据"];
                        [SNHUD hiddenWithDelay:1.5 Block:^{}];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (isShow) {
                    [SNHUD showError:error.localizedDescription];
                    [SNHUD hiddenWithDelay:1.5 Block:^{}];
                }
                [subscriber sendError:error];
            }];
            return [RACDisposable disposableWithBlock:^{
                //  block 调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
                //  执行完block后，当前信号就不再被订阅了。
                NSLog(@"signal disposed!");
            }];
        }];
    }];
}

//TODO:基础数据请求Get
-(RACCommand *)rac_commandWithGetRequestUrl:(NSString *)urlStr
                              isShowLoading:(BOOL)isShow {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *parameters) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            if (isShow) {
                [SNHUD show];
            }
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSLog(@"\n====请求接口===\n == %@\n====请求参数====\n=%@\n",urlStr,parameters);
            [manager GET:urlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isShow) {
                    [SNHUD hiddenWithBlock:^{}];
                }
                NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
                if (jsondic != nil && ![jsondic isKindOfClass:[NSNull class]]) {
                    [subscriber sendNext:jsondic];
                    [subscriber sendCompleted];
                }else{
                    if (isShow) {
                        [SNHUD showError:@"非json格式数据"];
                        [SNHUD hiddenWithDelay:1.5 Block:^{}];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (isShow) {
                    [SNHUD showError:error.localizedDescription];
                    [SNHUD hiddenWithDelay:1.5 Block:^{}];
                }
                [subscriber sendError:error];
            }];
            return [RACDisposable disposableWithBlock:^{
                //  block 调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
                //  执行完block后，当前信号就不再被订阅了。
                NSLog(@"signal disposed!");
            }];
        }];
    }];
}

/* 传参接口POST
 * @param urlStr 网络请求地址
 * @param parameters 网络请求参数
 * @param isShow 是否展示菊花
*/
-(RACSignal *)rac_signalRequestWithPostUrl:(NSString *)urlStr
                                 withParam:(NSDictionary *)parameters
                             isShowLoading:(BOOL)isShow {
    return [[[self rac_commandWithPostRequestUrl:urlStr isShowLoading:isShow] execute:parameters] map:^id _Nullable(id  responseObject) {
        NSLog(@"原始网路返回数据===\n%@",responseObject);
        return responseObject;// 映射为理想数据模型
    }];
}

/* 传参接口GET
* @param urlStr 网络请求地址
* @param parameters 网络请求参数
* @param isShow 是否展示菊花
*/
-(RACSignal *)rac_signalRequestWithGetUrl:(NSString *)urlStr
                                withParam:(NSDictionary *)parameters
                            isShowLoading:(BOOL)isShow {
    return [[[self rac_commandWithGetRequestUrl:urlStr isShowLoading:isShow] execute:parameters] map:^id _Nullable(id  responseObject) {
        NSLog(@"原始网路返回数据===\n%@",responseObject);
        return responseObject;// 映射为理想数据模型
    }];
}
@end
