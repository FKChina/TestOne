//
//  JSWoVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/6.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSWoVC.h"
@interface JSWoVC ()


//@property (strong, nonatomic) IBOutletCollection(JSPhoneBtn) NSArray *phoneBtnArr;


@end

@implementation JSWoVC

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
-(void)viewWillAppear:(BOOL)animated
{
//    [self refrashNavigationBar];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self configUI];
    
}
//内存告警
#pragma mark
#pragma mark -MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//用户界面
#pragma mark
#pragma mark -UI
-(void)configUI
{
    
    NSArray * arr = @[@"4006828393",@"057186461133",@"18157177006",@"13357125997",@"13958182272",@"18329122657"];
    
//    for (int i = 0; i < _phoneBtnArr.count; i ++) {
//        JSPhoneBtn * btn = _phoneBtnArr[i];
//        btn.phoneNumber = arr[i];
//        [btn addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
}
//数据处理
#pragma mark
#pragma mark -Data

//逻辑功能
#pragma mark
#pragma mark -Function




/**
 *点击电话弹出选择框
 */
-(IBAction)callAction:(JSPhoneBtn *)btn
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否拨打以下电话？" message:btn.phoneNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
            NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",alertView.message];
            //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            //    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",number];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
        }
            break;
        default:
            break;
    }
}
//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party






@end
