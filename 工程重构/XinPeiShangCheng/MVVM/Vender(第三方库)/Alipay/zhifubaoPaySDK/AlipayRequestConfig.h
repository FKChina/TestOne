//
//  AlipayRequestConfig.h
//  ytx
//
//  Created by valor on 15/11/16.
//  Copyright © 2015年 Valor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlipayHeader.h"

@interface AlipayRequestConfig : NSObject

/**
 *  配置请求信息，仅有变化且必要的参数
 *
 *  @param partner            合作者身份ID
 *  @param seller             卖家支付宝账号
 *  @param tradeNO            商户网站唯一订单号
 *  @param productName        商品名称
 *  @param productDescription 商品详情
 *  @param amount             总金额
 *  @param notifyURL          服务器异步通知页面路径
 */
+ (void)alipayWithPartner:(NSString *)partner
                   seller:(NSString *)seller
                  tradeNO:(NSString *)tradeNO
              productName:(NSString *)productName
       productDescription:(NSString *)productDescription
                   amount:(NSString *)amount
                notifyURL:(NSString *)notifyURL;

@end

/**
 *  支付宝的一些参数的生成
 */
@interface AlipayToolKit : NSObject

+ (NSString *)genTradeNoWithTime;

@end

