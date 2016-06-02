//
//  NET.m
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "NET.h"

@implementation NET


/**
 *  传入方法名actionname
 *
 *  参数
 *
 *  获取网络数据
 */
-(void)getPictureWithDic:(NSDictionary *)dic
       CompelementHandle:(CompeleHandle)handle
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:TEST_PATH parameters:dic progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (responseObject)
         {
             NSMutableArray * arr = [NSMutableArray new];
             for (NSDictionary * dic in responseObject) {
                 JSNeiRongModel * model = [[JSNeiRongModel alloc]initWithDictionary:dic error:nil];
                 [arr addObject:model];
             }
             handle(arr);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"%@",error);
     }];
}

/**
 *  传入方法名actionname
 *
 *  参数
 *
 *  获取网络数据
 */
-(void)getDataWithDic:(NSDictionary *)dic
        CompelementHandle:(CompeleHandle)handle{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:TEST_PATH_2 parameters:dic progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //判断方法类型
         if ([[dic objectForKey:@"actionname"] isEqualToString:@"loadtitlepic"] || [[dic objectForKey:@"actionname"] isEqualToString:@"setmealpicurl_get"])
         {//加载广告信息
             if (responseObject)
             {
                 NSMutableArray * arr = [NSMutableArray new];
                 for (NSDictionary * dic in responseObject) {
                     
                     JSNeiRongModel * model = [[JSNeiRongModel alloc]initWithDictionary:dic error:nil];
                     [arr addObject:model];
                 }
                 handle(arr);
             }
         }
         else if ([[dic objectForKey:@"actionname"] isEqualToString:@"add_user_car"])
         {//新增用户车库
             handle(responseObject);
         }
         else if ([[dic objectForKey:@"actionname"] isEqualToString:@"user_car_get"])
         {//根据uid用户车库数据
             if (responseObject)
             {
                 UserModelOne * model = [[UserModelOne alloc]initWithDictionary:responseObject error:nil];
                 handle(model);
             }
         }
         else if ([[dic objectForKey:@"actionname"] isEqualToString:@"carseries_get_all"])
         {//获取所有车库数据
             if (responseObject) {
                 NSMutableArray * arr = [NSMutableArray new];
                 NSArray * arr1 = responseObject;
                 if (arr1.count != 0)
                 {
                     for (NSDictionary * dic in responseObject) {
                         CheXiModel * model = [[CheXiModel alloc]initWithDictionary:dic error:nil];
                         [arr addObject:model];
                     }
                 }
                 handle(arr);
             }
         }else if ([[dic objectForKey:@"actionname"] isEqualToString:@"GoBuy"])
         {//生成订单
             JSDingDanXinXiModel * model = [[JSDingDanXinXiModel alloc]initWithDictionary:responseObject error:nil];
             handle(model);
         }
         else if ([[dic objectForKey:@"actionname"] isEqualToString:@"LoadTypeCarForCarTypeId"])
         {//通过cartypeID获取Pid（推荐车型）
             if (responseObject != nil) {
                 NSString * Pid = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"NewPrice"]];
                 handle(Pid);
             }
         }
         else if ([[dic objectForKey:@"actionname"] isEqualToString:@"orderinfobyuid"])
         {//通过Uid获取所有订单信息
             if ([[[responseObject objectForKey:@"result"]objectForKey:@"key"]isEqualToString:@"1"])
             {
                 NSArray * arr = [[responseObject objectForKey:@"result"]objectForKey:@"rows"];
                 NSMutableArray * resultarr = [NSMutableArray new];
                 for (NSDictionary * dic1 in arr) {
                     JSDingDanModel * model = [[JSDingDanModel alloc]initWithDictionary:dic1 error:nil];
                     [resultarr addObject:model];
                 }
                 handle(resultarr);
             }
         }else if ([[dic objectForKey:@"actionname"] isEqualToString:@"Update_Order"])
         {//修改订单状态
             
         }else if ([[dic objectForKey:@"actionname"] isEqualToString:@"getxlcinfobyaddress"])
         {//获取附近网点数据
             if (responseObject)
             {
                 JSBranchesModelOne *model = [[JSBranchesModelOne alloc]initWithDictionary:responseObject error:nil];
                 handle(model);
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [MBProgressHUD showError:@"网络出错"];
     }];
}

/** 
 *  获取网络数据
 *  参数(包含方法名)
 *
 *  获取数据block
 *
 *  获取错误信息block
 *
 *  获取失败信息block
 */
-(void)getDataWithDictionary:(NSDictionary *)dic
       WithJSReturnDataBlock:(JSReturnDataBlock)data
     WithJSErrorMessageBlock:(JSErrorMessageBlock)errorMessage
   WithJSFailureMessageBlock:(JSFailureMessageBlock)failureMessage
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:TEST_PATH_2 parameters:dic progress:^(NSProgress * _Nonnull downloadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         data(responseObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         errorMessage(error);
     }];
}






@end
