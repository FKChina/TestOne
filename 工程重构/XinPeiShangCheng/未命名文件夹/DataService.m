//
//  DataService.m
//  XinPei
//
//  Created by 醉卧沙场君莫笑 on 16/3/21.
//  Copyright © 2016年 glory.js.com. All rights reserved.
//

#import "DataService.h"
#import <AFNetworking.h>
@implementation DataService

-(void)getBargainDataWithParamenter:(NSString *)string andWithCompelete:(CompeleteHandler)handler
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"asd" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress)
    {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"%@",error);
    }];
}


-(void)uodateDataWithBody:(NSString *)string andWithCompelete:(CompeleteHandler)handler
{
    
    NSURL * url = [NSURL URLWithString:@"asdafagag"];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"" forHTTPHeaderField:@""];
    NSDictionary * data = @{@"order_id" : @"123",@"user_id" : @"789",@"shop" : @"Toll"};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = jsonData;
//    发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%ld",data.length);
    }];
}
@end
