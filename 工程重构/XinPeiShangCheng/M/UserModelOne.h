//
//  UserModelOne.h
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/31.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSBaseModel.h"
#import "UserCarModel.h"


@interface UserModelOne : JSBaseModel


@property (nonatomic, strong) NSArray<UserCarModel> *rows;
@property (nonatomic, copy) NSString *statecode;

@end
