//
//  JSXPCheKuViewController.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPCheKuViewController.h"
#import "JSXPCheKuTableView.h"

#define SCREEN_COUNT 17

@interface JSXPCheKuViewController ()
//定义属性
#pragma mark
#pragma mark -Attribute


{
    JSXPCheKuTableView * _cheKuList;
}


@end

@implementation JSXPCheKuViewController



//初始化值
#pragma mark
#pragma mark -Init

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
//界面将要出现时更新车库数据--本地数据
-(void)viewWillAppear:(BOOL)animated
{
    //    刷新导航栏
    [self refrashNavigationBar];
    //    判断数据是否要刷新
    if ([self isNeedRefrash]) {
        [_cheKuList.mj_header beginRefreshing];
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat height = SCREEN_HEIGHT_WNavigation(17);
    CGFloat jianGe = SCREEN_WIDTH/6;
    
    
//    车牌列表
    _cheKuList = [[JSXPCheKuTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height * 15)];
    [self.view addSubview:_cheKuList];
    
//    添加新车按钮
    WHButton * addBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(jianGe, height * 15, SCREEN_WIDTH - jianGe *2, height);
    [addBtn setButtonTitle:@"添加车型" TitleColor:XINPEI_COLOR BackGroundColor:[UIColor orangeColor] font:15 cornerRadius:height/2];
    [addBtn addTarget:self action:@selector(toAddView:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setBornerWidth:1 color:XINPEI_COLOR];
    [self.view addSubview:addBtn];
    
//    添加确定按钮
    WHButton * queRenBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    queRenBtn.frame = CGRectMake(jianGe, height * 16, SCREEN_WIDTH - jianGe *2, height);
    [queRenBtn setButtonTitle:@"确定" TitleColor:XINPEI_COLOR BackGroundColor:[UIColor orangeColor] font:15 cornerRadius:height/2];
    [queRenBtn addTarget:self action:@selector(popToSuper:) forControlEvents:UIControlEventTouchUpInside];
    [queRenBtn setBornerWidth:1 color:XINPEI_COLOR];
    [self.view addSubview:queRenBtn];
}
//数据处理
#pragma mark
#pragma mark -Data

//逻辑功能
#pragma mark
#pragma mark -Function
-(void)changeOrderMessage
{
    //    修改订单车牌
    [[NSUserDefaults standardUserDefaults]setObject:_cheKuList.chePai forKey:USER_CHEPAI];
    //    修改订单车型
    [[NSUserDefaults standardUserDefaults]setObject:_cheKuList.cheXing forKey:USER_CHEXING];
    //    修改cartypeid
    [[NSUserDefaults standardUserDefaults]setObject:_cheKuList.cheKuCarId forKey:USER_CHEXINGID];
    //    修改套餐信息
    //    ………………………………
    //    修改是否需要刷新状态
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:USER_ISREFRASH];
}
//界面跳转
#pragma mark
#pragma mark -Push
-(IBAction)toAddView:(id)sender
{
    
    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self.navigationController pushViewController:[SB instantiateViewControllerWithIdentifier:@"TianJiaVC"] animated:YES];
}

-(IBAction)popToSuper:(id)sender
{
    if ([JSXPStringPanDuan dealWithArr:@[_cheKuList.cheXing,_cheKuList.chePai] withString:@""] ) {
        [MBProgressHUD showMessage:@"匹配中……"];
        [[NET new]getDataWithDic:@{@"actionname":@"LoadTypeCarForCarTypeId",@"CarTypeId":_cheKuList.carId}
         
               CompelementHandle:^(id data) {
                   NSString * Pid = data;
                   [MBProgressHUD hideHUD];
                   [self changeOrderMessage];
                   //             根据Pid修改车型对应套餐
                   if ([Pid isEqualToString:@"15"])
                   {
                       //                 推荐一类套餐
                       [[NSUserDefaults standardUserDefaults]setObject:@"7" forKey:USER_TAOCANTYPE];
                   }else if ([Pid isEqualToString:@"40"])
                   {
                       //                 推荐二类套餐
                       [[NSUserDefaults standardUserDefaults]setObject:@"6" forKey:USER_TAOCANTYPE];
                   }else if ([Pid isEqualToString:@"60"])
                   {
                       //                 推荐三类套餐
                       [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:USER_TAOCANTYPE];
                   }
                   if ([self.tiaoZhuanZhuangTai isEqualToString:@"0"]) {
                       [self.navigationController popViewControllerAnimated:YES];
                   }else if ([self.tiaoZhuanZhuangTai isEqualToString:@"1"])
                   {
                       [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:YES];
                   }
               }];
    }
}
//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party

@end
