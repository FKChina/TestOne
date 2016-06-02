//
//  JSYuYueVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/6.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSYuYueVC.h"


#import "JSXPDingDanTableView.h"

@interface JSYuYueVC ()

@property (nonatomic,strong) JSXPDingDanTableView * dingDanTableView;//数据源

@end
@implementation JSYuYueVC






#pragma mark
#pragma mark View_Life_Cycle

-(void)viewWillAppear:(BOOL)animated
{
    [self isLogin];
    [self refrashNavigationBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
}
#pragma mark
#pragma mark MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark UI
-(void)configUI
{
    
}
//视图周期
#pragma mark
#pragma mark View_Life_Cycle

//界面搭建
#pragma mark
#pragma mark UI

//数据源
#pragma mark
#pragma mark Data

//逻辑处理
#pragma mark
#pragma mark Function

//相应事件
#pragma mark
#pragma mark Action

//执行代理
#pragma mark
#pragma mark Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party

//内存管理
#pragma mark
#pragma mark MemoryWarning

#pragma mark
#pragma mark Function

/**
 *判断是否登录
 */
-(void)isLogin
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:USER_ULOGINSTATE] isEqualToString:@"1"])
    {
        [self.view addSubview:self.dingDanTableView];
    }else
    {
        [self.dingDanTableView removeFromSuperview];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有权限" message:@"是否登陆？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:cancelAction];
        UIAlertAction * loginAction = [UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pushTologin];
        }];
        [alertController addAction:loginAction];
        [self presentViewController:alertController animated:YES completion:^{
        }];
    }
}

#pragma mark
#pragma mark Delegate


//三方工具
#pragma mark
#pragma mark -Third-Party

@end
