//
//  JSXPWangDianTableView.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSXPWangDianTableView : UITableView
/**
 *  构造方法创建车库列表
 *
 *  @param frame fra
 *
 *  @return 返回一个列表
 */
-(instancetype)initWithFrame:(CGRect)frame;
/**
 *  位置
 */
@property (nonatomic , copy) NSString * loaction;

@end
