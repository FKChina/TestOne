//
//  AppDelegate.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/3/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    RootViewController * rootViewController = [[RootViewController alloc]init];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    
    // 1.设置导航栏背景
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:XINPEI_COLOR];
    [bar setTranslucent:NO];
    
    
    
    // 2.设置导航栏文字属性
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:XINPEI_COLOR forKey:UITextAttributeTextColor];
    [barAttrs setObject:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
    [bar setTitleTextAttributes:barAttrs];
    
    
//
//    // 3.按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    设置按钮背景图片
//    [item setBackgroundImage:[UIImage resizeImage:@"icon7_"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage resizeImage:@"icon6_"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//
//    
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionaryWithDictionary:barAttrs];
    [itemAttrs setObject:[UIFont boldSystemFontOfSize:15] forKey:UITextAttributeFont];
    
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateDisabled];
    
    
    
    // 4.全局返回按钮背景图片
    
//    [item setBackButtonBackgroundImage:[UIImage resizeImage:@"icon7_"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackButtonBackgroundImage:[UIImage resizeImage:@"icon6_"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
//    设置选项卡字体--颜色--全局
    [[UITabBarItem appearance]
     setTitleTextAttributes:@{NSForegroundColorAttributeName:XINPEI_COLOR}
                                                                          forState:UIControlStateSelected];
//    设置选项卡图片--颜色--全局
    [[UITabBar appearance] setTintColor:XINPEI_COLOR];
    //键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    //IQKeyBoard
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:0];
    
    //    设置网络监听事件
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:USER_WANGLUOSTATE];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:USER_WANGLUOSTATE];

            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:USER_WANGLUOSTATE];

            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:USER_WANGLUOSTATE];

            }
                break;
            default:
                break;
        }
    }];

    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
