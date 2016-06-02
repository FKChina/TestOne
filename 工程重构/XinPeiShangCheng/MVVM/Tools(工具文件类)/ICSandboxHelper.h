//
//  ICSandboxHelper.h
//  XinPei
//
//  Created by 醉卧沙场君莫笑 on 16/3/25.
//  Copyright © 2016年 glory.js.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICSandboxHelper : NSObject

+ (NSString *)homePath;     // 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)appPath;        // 程序目录，不能存任何东西
+ (NSString *)docPath;        // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)libPrefPath;    // 配置目录，配置文件存这里
+ (NSString *)libCachePath;    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;        // 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (BOOL)hasLive:(NSString *)path; //判断目录是否存在，不存在则创建

/**
 *  判断数组里的字符串是否有空值
 *
 *  @param stringArr 字符串数组
 *
 *  @return yes = 没有空值 ，no = 有空值
 */
+(BOOL)dealWithStrArr:(NSArray *)stringArr;


+ (int)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;

+ (NSString *)getTheDay;

@end
