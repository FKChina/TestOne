//
//  Config.h
//  JSBase
//
//  Created by 醉卧沙场君莫笑 on 16/5/20.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#ifndef Config_h
#define Config_h


typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock) (id failureCode);
typedef void (^WayValueBlock) (id WayValue);

//方法宏

//属性宏

//数据宏

//划分屏幕



#define MAXMinute 15
#define MAXTime 3

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define winH [UIScreen mainScreen].bounds.size.height
#define winW [UIScreen mainScreen].bounds.size.width
#define UIX [UIScreen mainScreen].bounds.size.width/7
#define space 30

#define jinsen1328  mishi
#define RootLocation @"http://211.155.229.230:8002/xp_interface/xp_test.ashx?"
#define lastDay @"lastDay"
#define lastTime @"haveApplyTime"
#define TEST_PATH @"http://wap.xinpeiauto.com/xp_interface/xp_test.ashx?"
#define TEST_PATH_2 @"http://211.155.229.230:8002/xp_interface/xp_test.ashx?"
#define XINPEI_COLOR [UIColor colorWithRed:255/255.0 green:68/255.0 blue:1/255.0 alpha:1.0]

//NSUserDefaults--标识
#define USER_UID @"Uid"                  //用户id
#define USER_NAMEORPHONE @"UName/UPhone" //用户名/电话
#define USER_PWD @"PWD"                  //用户密码
#define USER_ULOGINSTATE @"ULoginState"  //登录状态
#define USER_PRICE @"UPrice"             //支付价格
#define USER_ORDERID @"orderId"          //订单id
#define USER_CHEPAI @"UchePai"           //车牌
#define USER_CHEXING @"UcheXing"         //车牌对应车型
#define USER_CHEXINGID @"UcheXingId"     //车型对应id
#define USER_TAOCANTYPE @"UTaoCanType"   //车型对应套餐
#define USER_TIAOZHUANSKIP @"USkip"      //界面跳转状态
#define USER_ISREFRASH @"isRefrash"      //是否需要刷新0-不需要  1-需要
#define USER_WANGLUOSTATE @"wangLuoState"      //网络状态1 -正常 2 -断开
#define ZHIFU_STATU @"zhiFuStatu"        //1  刚刚完成支付活动并成功  0  没有支付行为或失败

// 判断是否为iOS7
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH_BORDER ([UIScreen mainScreen].bounds.size.width * 0.02)
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_HEIGHT_BORDER 64
#define FOOTVIEW_HEIGHT 60
#define ADVERTISEMENT_HEIGHT 200


//画屏幕

#define SCREEN_CELL_HEIGHT(i) [UIScreen mainScreen].bounds.size.height/i
#define SCREEN_CELL_WIDTH(i) [UIScreen mainScreen].bounds.size.width/i
//状态栏高度
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define NAV_HEIGHT self.navigationController.navigationBar.frame.size.height

#define SCREEN_HEIGHT_WNavigation(i) (SCREEN_HEIGHT - STATUS_HEIGHT - NAV_HEIGHT)/i

#define TABBAR_HEIGHT 49

#define ADVERTISEMENT_HEIGHT_PAGE_WIDTH 30
#define ADVERTISEMENT_HEIGHT_PAGE_HEIGHT 20
#define FUGAI_VIEW_WIDTH 58

#endif /* Config_h */
