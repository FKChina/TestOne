//
//  WHNetWorking.m
//  登录注册
//
//  Created by 杭州信配 on 16/3/30.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import "WHNetWorking.h"

@implementation WHNetWorking
#pragma --mark GET请求方式
+(void)operationManagerGET:(NSString *)url parameters:(id )params WithReturnValeuBlock: (ReturnValueBlock) block
        WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
          WithFailureBlock: (FailureBlock) failureBlock{    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         block(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         failureBlock(error);
         NSLog(@"%@",error);
     }];
}

@end
