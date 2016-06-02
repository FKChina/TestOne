//
//  JSGeRenZhongXinViewController.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSGeRenZhongXinViewController.h"

@interface JSGeRenZhongXinViewController ()

@end

@implementation JSGeRenZhongXinViewController


//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
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
-(void)configUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat gap = 10;
    CGFloat number = 3;
    CGFloat btnWidth = (SCREEN_WIDTH-((number + 1) * gap))/3;
    CGFloat btnHeight = SCREEN_HEIGHT/9;
    
    int col = 0;
    int row = 0;
    NSArray * arr = @[@"已购买产品",@"我的车库",@"我的积分",@"个人信息",@"我的留言",@"退出登录",@"加盟商"];
    NSArray * image = @[@"13",@"12",@"11",@"23",@"22",@"21",@"31"];
    for (int i = 0; i < arr.count; i ++)
    {
        if (i == arr.count - 1)
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(gap, btnHeight + btnHeight + btnHeight + btnHeight * row- btnHeight/4 , SCREEN_WIDTH- gap, btnHeight/4)];
            [imageView setImage:[UIImage imageNamed:@"座"]];
            [self.view addSubview:imageView];
            [self.view sendSubviewToBack:imageView];
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((SCREEN_WIDTH - 2 * btnWidth)/2, btnHeight + btnHeight * row, 2 * btnWidth, 2 * btnHeight);
            btn.tag = 100001 + i;
            [btn setBackgroundImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
            [btn addTarget:self  action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            JSBaseLabel * label = [[JSBaseLabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 2 * btnWidth)/2, btnHeight + btnHeight + btnHeight + btnHeight * row, 2 * btnWidth, btnHeight/3)];
            
            
            [label setLabelTitle:arr[i] TitleColor:XINPEI_COLOR BackGroundColor:[UIColor clearColor] font:12 cornerRadius:0 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
            
            [self.view addSubview:label];
        }else
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(gap, btnHeight + btnHeight - btnHeight/4 , SCREEN_WIDTH- gap, btnHeight/4)];
            [imageView setImage:[UIImage imageNamed:@"座"]];
            [self.view addSubview:imageView];
            [self.view sendSubviewToBack:imageView];
            UIImageView * imageViewOne = [[UIImageView alloc]initWithFrame:CGRectMake(gap, btnHeight + btnHeight + btnHeight * 2 - btnHeight/4 , SCREEN_WIDTH- gap, btnHeight/4)];
            [imageViewOne setImage:[UIImage imageNamed:@"座"]];
            [self.view addSubview:imageViewOne];
            [self.view sendSubviewToBack:imageViewOne];
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(gap + (btnWidth + gap) * col, btnHeight + btnHeight * row, btnWidth, btnHeight);
            btn.tag = 100001 + i;
            [btn setBackgroundImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
            [btn addTarget:self  action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            JSBaseLabel * label = [[JSBaseLabel alloc]initWithFrame:CGRectMake(gap + (btnWidth + gap) * col, btnHeight + btnHeight + btnHeight * row, btnWidth, btnHeight/3)];
            [label setLabelTitle:arr[i] TitleColor:XINPEI_COLOR BackGroundColor:[UIColor clearColor] font:12 cornerRadius:0 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
            [self.view addSubview:label];
        }
        col ++;
        if (col == 3) {
            col = 0;
            row += 2;
        }
    }
}
//数据处理
#pragma mark
#pragma mark -Data

//逻辑功能
#pragma mark
#pragma mark -Function

-(IBAction)btnClicked:(UIButton *)btn
{
    if (btn.tag == 100001) {
//        已购买产品
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        JSYuYueVC * XQVC = [sb instantiateViewControllerWithIdentifier:@"JSYuYueVC"];
        [self.navigationController pushViewController:XQVC animated:YES];
        
    }else if (btn.tag == 100002)
    {
//        我的车库
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        XuanZeVC * VC = [sb instantiateViewControllerWithIdentifier:@"XuanZeVC"];
        [self.navigationController pushViewController:VC animated:YES];
        VC.tiaoZhuanZhuangTai = @"1";
    }else if (btn.tag == 100003)
    {
//        我的积分
        [self.navigationController pushViewController:[[JSIntegralViewController alloc]init] animated:YES];
    }else if (btn.tag == 100004)
    {
//        个人信息
    }else if (btn.tag == 100005)
    {
        
//        我的留言
        [self.navigationController pushViewController:[[JSLeaveMessageViewController alloc]init] animated:YES];
    }else if (btn.tag == 100006)
    {
//        退出系统
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:USER_ULOGINSTATE];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_UID];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_PRICE];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_ORDERID];
        [[NSUserDefaults standardUserDefaults]setObject:@"(空)" forKey:USER_CHEPAI];
        [[NSUserDefaults standardUserDefaults]setObject:@"(空)" forKey:USER_CHEXING];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_CHEXINGID];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_TAOCANTYPE];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_TIAOZHUANSKIP];
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:USER_ISREFRASH];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_NAMEORPHONE];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (btn.tag == 100006)
    {
//        加盟商
    }
}


/**
 *清除用户信息
 */
-(IBAction)quit:(id)sender
{

}
//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party

@end
