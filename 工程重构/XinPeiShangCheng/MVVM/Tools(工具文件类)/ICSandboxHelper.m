//
//  ICSandboxHelper.m
//  XinPei
//
//  Created by 醉卧沙场君莫笑 on 16/3/25.
//  Copyright © 2016年 glory.js.com. All rights reserved.
//

#import "ICSandboxHelper.h"

#define MAXMinute 15
#define MAXTime 3

@implementation ICSandboxHelper

+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)hasLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}


+(BOOL)dealWithStrArr:(NSArray *)stringArr
{
    BOOL kong = YES  ;
    for (NSString * str in stringArr) {
        if ([str isEqualToString:@""] || str == nil) {
            kong = NO;
        }
    }
    return kong;
}


//获取当前时间
+ (NSString *)getTheDay{
    NSDate *date  = [NSDate date];
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dm stringFromDate:date];
    return time;
}


/**
 *  <#Description#>
 *
 *  @param inBeginDay 指定的时间
 *
 *  @return 距离指定时间的天数
 */
+ (int)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    dateString2 = [ICSandboxHelper getTheDay];
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [date setTimeZone:timeZone];
    NSDate *d1=[date dateFromString:dateString1];
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    NSDate *d2=[date dateFromString:dateString2];
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
    if([house intValue] >=1){
        return MAXMinute;
    }
    else if([min intValue]>MAXMinute){
        return [min intValue];
    }
    else{
        return [min intValue];
    }
    return nil;
}

@end
