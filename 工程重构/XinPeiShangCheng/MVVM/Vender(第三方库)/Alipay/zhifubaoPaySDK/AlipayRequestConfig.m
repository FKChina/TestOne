//
//  AlipayRequestConfig.m
//  ytx
//
//  Created by valor on 15/11/16.
//  Copyright © 2015年 Valor. All rights reserved.
//

#import "AlipayRequestConfig.h"

@implementation AlipayRequestConfig

// 仅含有变化的参数
+ (void)alipayWithPartner:(NSString *)partner
                   seller:(NSString *)seller
                  tradeNO:(NSString *)tradeNO
              productName:(NSString *)productName
       productDescription:(NSString *)productDescription
                   amount:(NSString *)amount
                notifyURL:(NSString *)notifyURL
{
    [self alipayWithPartner:partner seller:seller tradeNO:tradeNO productName:productName productDescription:productDescription amount:amount notifyURL:notifyURL service:@"mobile.securitypay.pay" paymentType:@"1" inputCharset:@"utf-8" itBPay:@"30m" privateKey:XPPrivateKey appScheme:XAppScheme];
}

+ (void)alipayWithPartner:(NSString *)partner//
                   seller:(NSString *)seller
                  tradeNO:(NSString *)tradeNO
              productName:(NSString *)productName
       productDescription:(NSString *)productDescription
                   amount:(NSString *)amount
                notifyURL:(NSString *)notifyURL
                  service:(NSString *)service
              paymentType:(NSString *)paymentType
             inputCharset:(NSString *)inputCharset
                   itBPay:(NSString *)itBPay
               privateKey:(NSString *)privateKey
                appScheme:(NSString *)appScheme{
    /*
     *生成订单信息及签名
     */
    
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    
    
    order.tradeNO = tradeNO; //订单ID（由商家自行制定）
    //商品标题
    order.productName = productName;
    //商品描述
    order.productDescription = productDescription;
    //商品价格
    order.amount = amount;
    
#pragma mark 疑问1.
    order.notifyURL =  notifyURL; //回调URL
    
    //以下配置信息是默认信息,不需要更改.
    order.service = service;
    order.paymentType = paymentType;
    order.inputCharset = inputCharset;
    order.itBPay = itBPay;
    
    // 将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"%@",orderSpec);
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    
    NSString *signedString = [self genSignedStringWithPrivateKey:XPPrivateKey OrderSpec:orderSpec];
    
    // 调用支付接口
    [self payWithAppScheme:appScheme orderSpec:orderSpec signedString:signedString];
}

// 生成signedString
+ (NSString *)genSignedStringWithPrivateKey:(NSString *)privateKey OrderSpec:(NSString *)orderSpec {
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    return [signer signString:orderSpec];
}

// 支付
+ (void)payWithAppScheme:(NSString *)appScheme orderSpec:(NSString *)orderSpec signedString:(NSString *)signedString {
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString * resultString = [resultDic objectForKey:@"resultStatus"];
            if ([resultString isEqualToString:@"9000"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:ZHIFU_STATU];
            }else if([resultString isEqualToString:@"4000"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:ZHIFU_STATU];
            }else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:ZHIFU_STATU];
            }
        }];
    }
}


@end

@implementation AlipayToolKit

+ (NSString *)genTradeNoWithTime {
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
