//
//  AlipayHeader.h
//  ytx
//
//  Created by valor on 15/11/17.
//  Copyright © 2015年 JY. All rights reserved.
//

#ifndef AlipayHeader_h
#define AlipayHeader_h



#import <AlipaySDK/AlipaySDK.h>     // 导入AlipaySDK
#import "AlipayRequestConfig.h"     // 导入支付类
#import "Order.h"                   // 导入订单类
#import "DataSigner.h"              // 生成signer的类：获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode

#import <Foundation/Foundation.h>   // 导入Foundation，防止某些类出现类似：“Cannot find interface declaration for 'NSObject', superclass of 'Base64'”的错误提示


/**
 *  partner:合作身份者ID,以 2088 开头由 16 位纯数字组成的字符串。
 *
 */
/**
 *  与支付宝签约时的认证码
 *  商户ID（partner）
 */
#define XPPartnerID @""


/**
 *  seller:支付宝收款账号,手机号码或邮箱格式。
 */
/**
 *  公司收款账号
 *  和账号ID（seller）
 */
#define XPSeller @""

/**
 *  支付宝服务器主动通知商户 网站里指定的页面 http 路径。
 */
/**
 *  公司网站
 *
 */
#define XPNotifyURL @"www.xinpeiauto.com"
/**
 *  appSckeme:应用注册scheme,在Info.plist定义URLtypes，处理支付宝回调
 */
#define XAppScheme @"zhengchaojiealipay"


/**
 *  private_key:商户方的私钥,pkcs8 格式。
 */
/**
 *  公司私钥
 *
 */
#define XPPrivateKey @"MIICXQIBAAKBgQCt00EQa7rL4Fho4bhfaPAJLjKJv9k0ZfaXof6P1mWPerPWfmlcgmAVrks+WqkNGo4C+/5lZ+2jLon6OxXQtwZz2rkpYLb1uE4djZ3HFDbl8Ii4Svdi3hoFVxQ4SASNaadSI+eLcvEcqbiHIy812ERKjoVn/BEDZ7diXhvLhw6cLwIDAQABAoGAJrKHI564ITc6t2642xTDi2erfJsnQdEJSsyXnXH/fie07aWK0zt7JJh+y8znIbGtt+BdzDmM3+02bmzE+IgmeTorOj4DX4SgSM8dhyFpMCXAMroQGmsP3UZitbS2mlIMhW9/+IAecvm/6HCUzjNqt3rbkx9cEz4ZA6sqHYtkMbECQQDiJlw9TY/yEN2VN5K9QFUhWXnfqMQ0SOWxenYBYZfNMOUjJqre3HfHJlN3FsCXxLuPr4VVV1MNu1BytBVLFYv1AkEAxMTWB7IDIRjnaESv0Fe1o9bWXYBNZ1jAFeWgmONWCLVSFiuX+G25jRH4bW77gxZ5zpmPyArP7obdc/0xjt21EwJBAJKhprsE2GlusA15PAbDeK8n8dKn/ZedEHlT2sGogqHDqz5waugXcP5KhmG3+eYt5CMU/lHITgygQFgvFYNalCUCQQCjsPw8uqJPzl/0Je/86np5Kih68Fl0OCjUDotjpPvVksIPH4T1bpKGAQUiRMmHbBM5BBbQ2+3PCPMBowivSVFxAkBb3pBmozye7f5xOE4zGmiegIY9hcDaAwHIuQqmPg9NxtswmJlWpyvjDx5+KXILCslS1WLa9K1kDsYCK33kup1d"


#endif
