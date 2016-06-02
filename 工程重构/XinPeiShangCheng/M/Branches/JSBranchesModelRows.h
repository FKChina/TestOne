//
//  JSBranchesModelRows.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/19.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol JSBranchesModelRows

@end
@interface JSBranchesModelRows : JSONModel

@property (nonatomic, copy) NSString *Distiance;
@property (nonatomic, copy) NSString *Address;
@property (nonatomic, strong) NSNumber *GroupId;
@property (nonatomic, copy) NSString *GroupName;
@property (nonatomic, copy) NSString *Telephone;

@end
