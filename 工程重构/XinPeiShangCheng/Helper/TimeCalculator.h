//
//  TimeCalculator.h
//  登录注册
//
//  Created by 杭州信配 on 16/4/1.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeCalculator : NSString
+ (int)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
+ (NSString *)getTheDay;
@end
