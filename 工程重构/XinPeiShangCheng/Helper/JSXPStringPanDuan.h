//
//  JSXPStringPanDuan.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSXPStringPanDuan : NSObject
/**
 *  判断数组里的字符串是否有空值
 *
 *  @param stringArr 字符串数组
 *
 *  @return yes = 没有空值 ，no = 有空值
 */
+(BOOL)dealWithArr:(NSArray *)stringArr withString:(NSString *)string;

@end
