//
//  JSXPStringPanDuan.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPStringPanDuan.h"

@implementation JSXPStringPanDuan



+(BOOL)dealWithArr:(NSArray *)stringArr withString:(NSString *)string
{
    BOOL kong = YES  ;
    for (NSString * str in stringArr) {
        if ([str isEqualToString:@""] || str == nil || [str isEqualToString:string]) {
            kong = NO;
        }
    }
    return kong;
}
@end
