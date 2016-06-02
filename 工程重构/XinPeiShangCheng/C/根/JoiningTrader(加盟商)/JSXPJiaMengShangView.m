//
//  JSXPJiaMengShangView.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPJiaMengShangView.h"

@implementation JSXPJiaMengShangView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self loadData];
    }
    return self;
}

//定义属性
#pragma mark
#pragma mark -Attribute

//初始化值
#pragma mark
#pragma mark -Init

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle

//内存告警
#pragma mark
#pragma mark -MemoryWarning

//用户界面
#pragma mark
#pragma mark -UI
-(void)configUI
{
    
}
//数据处理
#pragma mark
#pragma mark -Data
-(void)loadData
{
    [[NET new]getDataWithDictionary:nil WithJSReturnDataBlock:^(id data) {
        
    } WithJSErrorMessageBlock:^(id errorMessage) {
        
    } WithJSFailureMessageBlock:^(id failureMessage) {
        
    }];
}
//逻辑功能
#pragma mark
#pragma mark -Function

//界面跳转
#pragma mark
#pragma mark -Push

//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party


@end
