//
//  JSBaseViewController.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/3/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSBaseViewController ()

@end

@implementation JSBaseViewController

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self refrashNavigationBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//内存告警
#pragma mark
#pragma mark -MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//用户界面
#pragma mark
#pragma mark -UI



-(void)refrashNavigationBar
{
    //    判断登录状态
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"ULoginState"] isEqualToString:@"1"])
    {
        UIImage * img = [[UIImage imageNamed:@"icon6_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 使用图片的方式创建
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton:)];
        [self.navigationItem setRightBarButtonItem:rightButton];
    }else
    {
        UIImage * img = [[UIImage imageNamed:@"登录"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 使用图片的方式创建
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton:)];
        [self.navigationItem setRightBarButtonItem:rightButton];
    }
}

//数据处理
#pragma mark
#pragma mark -Data



//逻辑功能
#pragma mark
#pragma mark -Function



/**
 *添加全局的导航栏右边按钮，进入个人中心还是登陆界面
 */
-(IBAction)clickRightButton:(id)sender
{
    //    判断登录状态
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:USER_ULOGINSTATE] isEqualToString:@"1"]) {
        //        是-->导航-->订购界面
        
        [self.navigationController pushViewController:[[JSGeRenZhongXinViewController alloc]init] animated:YES];
    }else{
        
        [self pushTologin];
    }
}

-(void)pushTologin
{
    [self.navigationController pushViewController:[[XPLoginViewController alloc]init] animated:YES];
}



-(void)isLoginSkipToWithJSViewControllers:(JSViewControllers)controller
{
    //    判断登录状态
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:USER_ULOGINSTATE] isEqualToString:@"1"]) {
        switch (controller) {
            case JSGeRenZhongXinViewControllerENUM:
            {
                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"JSGeRenZhongXinViewController"] animated:YES];
            }
                break;
            case ViewControllerENUM:
            {
                [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else
    {
        [self pushTologin];
    }
}

-(BOOL)isNeedRefrash
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:USER_ISREFRASH] isEqualToString:@"0"])
    {
        return NO;
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:USER_ISREFRASH];
        return YES;
    }
}



//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party


@end
