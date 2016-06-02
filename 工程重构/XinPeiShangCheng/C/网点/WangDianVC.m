//
//  WangDianVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/2.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "WangDianVC.h"

#import "JSXPWangDianTableView.h"


#define JSSafeString(str) (str == nil ? @"" : str)
#define LIMIT_COUNT 20



static NSString * identifierForWangDianCell = @"identifierForWangDianCell";

@interface WangDianVC ()<JSDiTuVCDelegate>


@property (strong , nonatomic) JSXPWangDianTableView * wangDianTableView;


@end
@implementation WangDianVC


#pragma mark
#pragma mark View_Life_Cycle



-(void)viewWillAppear:(BOOL)animated
{
//    [self refrashNavigationBar];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    加载界面
//    [self configUI];

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
    CGFloat width = SCREEN_WIDTH/5;
    CGFloat height = SCREEN_HEIGHT_WNavigation(10);
    
    
    
    JSBaseLabel * location = [[JSBaseLabel alloc]initWithFrame:CGRectMake(0, 0, width * 4, height)];
    [location setLabelTitle:self.wangDianTableView.loaction TitleColor:[UIColor redColor] BackGroundColor:[UIColor whiteColor] font:12 cornerRadius:height/2 boardSize:1 boardColor:[UIColor cyanColor] textAlignment:NSTextAlignmentCenter];
    
    location.adjustsFontSizeToFitWidth = YES;
    location.numberOfLines = 0;
    location.text = self.wangDianTableView.loaction;
    [self.view addSubview:location];
    
    WHButton * diTuBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    diTuBtn.frame = CGRectMake(width * 4, 0, width, height);
    [diTuBtn setButtonTitle:@"定位" TitleColor:[UIColor cyanColor] BackGroundColor:[UIColor whiteColor] font:16 cornerRadius:5];
    [diTuBtn addTarget:self action:@selector(dingWei:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:diTuBtn];
    
    self.wangDianTableView = [[JSXPWangDianTableView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, height * 9)];
    [self.view addSubview:self.wangDianTableView];
    
}
#pragma mark
#pragma mark Data

#pragma mark
#pragma mark Function

/**
 *开始定位
 */
-(IBAction)dingWei:(UIButton *)btn
{
    JSDiTuVC * vc = [[JSDiTuVC alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}





#pragma mark
#pragma mark -DELEGATE
#pragma mark 表格

#pragma mark 位置代理



@end
