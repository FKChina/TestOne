//
//  JSDingDanModelRows.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/25.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JSDingDanModelTable.h"

@interface JSDingDanModelRows : JSONModel


@property (nonatomic, copy) NSString *carnum; //车牌号

@property (nonatomic, copy) NSString *orderid; //订单id

@property (nonatomic, copy) NSString *fkstate; //支付状态--0=未支付--1=支付

@property (nonatomic, copy) NSString *proname; //套餐名称

@property (nonatomic, copy) NSString *carname; //车型号

@property (nonatomic, strong) JSDingDanModelTable *children;

@end
