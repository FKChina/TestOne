//
//  JSXPCheKuTableView.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSXPCheKuTableView : UITableView 


/**
 *  构造方法创建车库列表
 *
 *  @param frame fra
 *
 *  @return 返回一个列表
 */
-(instancetype)initWithFrame:(CGRect)frame;
//选中车的车型
@property(nonatomic,copy)NSString * cheXing;
//选中车的车牌
@property(nonatomic,copy)NSString * chePai;
//选中车的车牌
@property(nonatomic,copy)NSNumber * cheKuCarId;
//选中车的车牌
@property(nonatomic,copy)NSNumber * carId;

@end
