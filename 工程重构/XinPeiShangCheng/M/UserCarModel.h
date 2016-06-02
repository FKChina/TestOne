//
//  UserCarModel.h
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/31.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSBaseModel.h"


@protocol UserCarModel 

@end

@interface UserCarModel : JSBaseModel

@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, copy) NSString *CarName;
@property (nonatomic, copy) NSString *Newtime;
@property (nonatomic, strong) NSNumber *IsDelStateCode;
@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSString *FullName;
@property (nonatomic, copy) NSString *CarNum;
@property (nonatomic, strong) NSNumber *WX_UsersCountToday;
@property (nonatomic, strong) NSNumber *Uid;
@property (nonatomic, copy) NSString *CreateDateTime;
@property (nonatomic, copy) NSString *CarAge;
@property (nonatomic, strong) NSNumber *WX_UsersCount;
@property (nonatomic, strong) NSNumber *CarType;

@end
