//
//  NET.h
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef void (^CompeleHandle)(id data);
typedef void (^JSReturnDataBlock) (id data);
typedef void (^JSErrorMessageBlock) (id errorMessage);
typedef void (^JSFailureMessageBlock) (id failureMessage);


@interface NET : NSObject
/**
 *  传入方法名actionname
 *
 *  参数
 *
 *  获取网络数据
 */
-(void)getDataWithDic:(NSDictionary *)dic
    CompelementHandle:(CompeleHandle)handle;

/**
 *  传入方法名actionname
 *
 *  参数
 *
 *  获取网络数据
 */
-(void)getPictureWithDic:(NSDictionary *)dic
       CompelementHandle:(CompeleHandle)handle;

/**
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
       WithJSFailureMessageBlock:(JSFailureMessageBlock)failureMessage;


@end
