//
//  JSBranchesModelOne.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/19.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JSBranchesModelRows.h"

@interface JSBranchesModelOne : JSONModel
@property (nonatomic, strong) NSNumber *results;
@property (nonatomic, strong) NSArray<JSBranchesModelRows> *rows;

@end
