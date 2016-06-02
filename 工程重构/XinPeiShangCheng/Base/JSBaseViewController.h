//
//  JSBaseViewController.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/3/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPJSActivityIndicatorView.h"
typedef enum : NSUInteger {
    JSGeRenZhongXinViewControllerENUM,
    ViewControllerENUM,
} JSViewControllers;



@interface JSBaseViewController : UIViewController

/**
 *判断是否登陆
 */
//-(void)isLoginSkipToWithJSViewControllers:(JSViewControllers)controller;

/**
 *判断是否需要刷新
 */
-(BOOL)isNeedRefrash;

/**
 *导航到登陆界面
 */
-(void)pushTologin;
/**
 *刷新导航界面
 */
-(void)refrashNavigationBar;


@end
