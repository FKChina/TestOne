//
//  CheXiModel.h
//  接口测试
//
//  Created by 醉卧沙场君莫笑 on 16/4/11.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CheXingModel.h"


@interface CheXiModel : JSONModel


@property (copy , nonatomic) NSString * CarTypeId;
@property (copy , nonatomic) NSString * TypeName;
@property (copy , nonatomic) NSString * FirstL;
@property (copy , nonatomic) NSString * NewPrice;
@property (copy , nonatomic) NSArray<CheXingModel> * children;


@end
