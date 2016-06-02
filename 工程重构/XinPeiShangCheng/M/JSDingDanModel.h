//
//  JSDingDanModel.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/15.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSBaseModel.h"


@protocol JSDingDanModel
@end

@interface JSDingDanModel : JSBaseModel

@property (nonatomic, strong) NSNumber<Optional> *id;                //订单详情id（一个订单id对应四条详情id）
@property (nonatomic, strong) NSNumber<Optional> *fkstate;           //支付状态--0=未支付--1=支付
@property (nonatomic, copy) NSString<Optional>   *proname;           //套餐名称
@property (nonatomic, copy) NSString<Optional>   *identifycode;      //随机验证码
@property (nonatomic, strong) NSNumber<Optional> *isuse;             //是否使用
@property (nonatomic, strong) NSNumber<Optional> *orderid;           //订单id
@property (nonatomic, copy) NSString<Optional>   *carnum;            //车牌号
@property (nonatomic, copy) NSString<Optional>   *carname;           //车型号
@property (nonatomic, copy) NSString<Optional>   *usedate;           //使用日期
@property (nonatomic, copy) NSString<Optional>   *yydatetime;        //预约日期
@property (nonatomic, strong) NSNumber<Optional>   *yyorderid;         //未知
@property (nonatomic, strong) NSNumber<Optional>  *yystatecode;       //未知
@property (nonatomic, strong) NSNumber<Optional>   *yygroupid;         //修理厂id（通过这个获取修理厂信息）
@property (nonatomic, copy) NSString<Optional>  *yynewgroup;        //新修理厂的信息


@end
