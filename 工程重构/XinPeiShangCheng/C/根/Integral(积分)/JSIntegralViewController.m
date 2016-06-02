//
//  JSIntegralViewController.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSIntegralViewController.h"



@interface JSIntegralViewController ()

@property (nonatomic , strong) JSXPNoLoginView * loginView;

@property (nonatomic , strong) UIView * jiFenView;

@end

@implementation JSIntegralViewController
//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
-(void)viewWillAppear:(BOOL)animated
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:USER_ULOGINSTATE]isEqualToString:@"1"]) {
        [self loadJiFenView];
    }else
    {
        [self loadLoginView];
    }
}
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
    
    
    _loginView = [[JSXPNoLoginView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [_loginView.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    _jiFenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];


    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat toTop = 10;
    CGFloat toLift = 10;
    CGFloat jiFenViewWidth = SCREEN_WIDTH-20;
    CGFloat jiFenViewHeight = SCREEN_HEIGHT/3;

//    积分视图
    UIView * jiFenView = [[UIView alloc]initWithFrame:CGRectMake(toLift, toTop, jiFenViewWidth, jiFenViewHeight)];
    jiFenView.backgroundColor = [UIColor whiteColor];
    jiFenView.layer.cornerRadius = 10;
    jiFenView.layer.masksToBounds = YES;
    jiFenView.layer.borderWidth = 1;
    jiFenView.layer.borderColor = [[UIColor grayColor]CGColor];
    [_jiFenView addSubview:jiFenView];
    
//    积分视图标题
    JSBaseLabel * titleLabel = [[JSBaseLabel alloc]initWithFrame:CGRectMake(0, 0, jiFenViewWidth/2, jiFenViewHeight/5)];
    
    [titleLabel setLabelTitle:@"*积分兑换" TitleColor:[UIColor redColor] BackGroundColor:[UIColor clearColor] font:17 cornerRadius:jiFenViewHeight/5/2 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
    
    [jiFenView addSubview:titleLabel];
    
//    积分视图名称
    JSBaseLabel * nameTitle = [[JSBaseLabel alloc]initWithFrame:CGRectMake(jiFenViewWidth/4, jiFenViewHeight/5, jiFenViewWidth/2, jiFenViewHeight/5)];
    
    [nameTitle setLabelTitle:@"我的积分(信配积分)" TitleColor:[UIColor blackColor] BackGroundColor:[UIColor clearColor] font:14 cornerRadius:jiFenViewHeight/5/2 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
    [jiFenView addSubview:nameTitle];
    
    
//    积分数量列表
    JSBaseLabel * jiFenLabel = [[JSBaseLabel alloc]initWithFrame:CGRectMake(jiFenViewWidth/4, 2 *jiFenViewHeight/5, jiFenViewWidth/2, jiFenViewHeight/5)];
    jiFenLabel.textAlignment = NSTextAlignmentCenter;
    
    [jiFenLabel setLabelTitle:@"0" TitleColor:[UIColor redColor] BackGroundColor:[UIColor clearColor] font:17 cornerRadius:jiFenViewHeight/5/2 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
    
    [jiFenView addSubview:jiFenLabel];
    
    
//    点击使用btn
    
    
    
//    为开发标签
    JSBaseLabel * kaiFaLabel = [[JSBaseLabel alloc]initWithFrame:CGRectMake(0, 4 *jiFenViewHeight/5, jiFenViewWidth, jiFenViewHeight/5)];
    [kaiFaLabel setLabelTitle:@"积分商城和余额兑换功能正在开发中……" TitleColor:[UIColor lightGrayColor] BackGroundColor:[UIColor clearColor] font:12 cornerRadius:jiFenViewHeight/5/2 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
    
    [jiFenView addSubview:kaiFaLabel];
    
}

-(void)loadLoginView
{
    [_jiFenView removeFromSuperview];
    
    [self.view addSubview:_loginView];
}

-(void)loadJiFenView
{
    [_loginView removeFromSuperview];
    [self.view addSubview:_jiFenView];
}

//数据处理
#pragma mark
#pragma mark -Data
-(void)loadData
{
    
}
//逻辑功能
#pragma mark
#pragma mark -Function
-(IBAction)loginBtnClicked:(id)sender
{
    [self.navigationController pushViewController:[[XPLoginViewController alloc]init] animated:YES];
}
//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party


@end
