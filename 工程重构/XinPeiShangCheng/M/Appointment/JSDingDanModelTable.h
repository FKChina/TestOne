//
//  JSDingDanModelTable.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/25.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JSDingDanModel.h"

@protocol JSDingDanModelTable



@end
@interface JSDingDanModelTable : JSONModel

@property (nonatomic, strong)NSArray <JSDingDanModel,Optional> * Table;

@end
