//
//  XPLoginViewController.m
//  登录注册
//
//  Created by 杭州信配 on 16/3/29.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import "XPLoginViewController.h"
#import "WHButton.h"
#import "WHTextField.h"
#import "XPregistViewController.h"
#import "NET.h"
#import "UserModelOne.h"

@interface XPLoginViewController (){
    WHAlertController *vc;
    UserModelOne * _model;
}

@property(weak,nonatomic)WHButton *loginButton;
@property(weak,nonatomic)UIImageView *backgroundImage;
@property(weak,nonatomic)UITextField *phoneField;
@property(weak,nonatomic)UITextField *messageField;

@end

@implementation XPLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.phoneField.text = [[NSUserDefaults standardUserDefaults]objectForKey:USER_NAMEORPHONE];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    vc = [[WHAlertController alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//登录按钮 监听方法
- (void)loginButtonAction:(UIButton *)button{
    
    
    [self.phoneField resignFirstResponder];
    [self.messageField resignFirstResponder];
    if([self.phoneField.text isEqualToString:@""]){
        [vc setAlertShowWithTitle:@"温馨提示" message:@"请输入手机号" target:self];
    }
    else if([self.messageField.text isEqualToString:@""]){
         [vc setAlertShowWithTitle:@"温馨提示" message:@"请输入密码" target:self];
    }
    else{
        NSDictionary *dict = @{@"actionname":@"user_login",@"Username":self.phoneField.text ,@"userpwd":self.messageField.text};
        [_loginButton setTitle:@"登录中……" forState:UIControlStateNormal];
        [WHNetWorking operationManagerGET:RootLocation  parameters:dict WithReturnValeuBlock:^(id returnValue) {
            //服务器 返回数据 这里做处理
            for (NSString * key in dict) {
                NSLog(@"key-- %@value--%@",key, [dict objectForKey:key]);
            }
            NSDictionary *dict = returnValue;
            NSString *key = [NSString stringWithFormat:@"%@",[dict[@"result"]objectForKey:@"key"]];
            NSArray * arr = [dict[@"result"]objectForKey:@"rows"];
            NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:arr[0]];
            if([key isEqualToString:@"1"])
            { //登录成功
                [MBProgressHUD showSuccess:@"登录成功"];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"Uid"] forKey:USER_UID];
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneField.text forKey:USER_NAMEORPHONE];
                [[NSUserDefaults standardUserDefaults] setObject:key forKey:USER_ULOGINSTATE];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //延迟函数内部
                    [MBProgressHUD hideHUD];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }
            else{//登录失败
                [vc setAlertShowWithTitle:@"温馨提示" message:@"登录失败" target:self];
            }
        } WithErrorCodeBlock:^(id errorCode) {
            [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
            NSLog(@"%@",errorCode);
        } WithFailureBlock:^(id failureCode) {
            [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
            NSLog(@"%@",failureCode);
        }];
    }
}

//注册按钮 监听方法
- (void)registButtoinAction:(UIButton *)button{
    XPregistViewController *regist = [[XPregistViewController alloc]init];
    regist.choice = 1;  //1 表示 注册
    [self.navigationController pushViewController:regist animated:YES];
}

//忘记密码
- (void)forgetAction:(UIButton *)button{
    XPregistViewController *regist = [[XPregistViewController alloc]init];
    regist.choice = 2;  //2 表示 重设
    [self.navigationController pushViewController:regist animated:YES];
}



//文本框放弃键盘响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneField resignFirstResponder];
    [self.messageField resignFirstResponder];
}

//设置 UI
- (void)setupUI{
    //创建背景
    UIImageView *backgoundView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgoundView.backgroundColor = [UIColor whiteColor];
    backgoundView.userInteractionEnabled = YES;
    [self.view addSubview:backgoundView];
    self.backgroundImage = backgoundView;
    
    //创建登录按钮
    CGFloat loginX = UIX;
    CGFloat loginW = winW-UIX*2;
    CGFloat loginY = self.view.center.y-UIX/2;
    CGFloat loginH = 5+ UIX/2;
    WHButton *loginButtoin = [[WHButton alloc]initWithFrame:CGRectMake(loginX,loginY, loginW, loginH)];
    [loginButtoin setButtonTitle:@"登录" TitleColor:[UIColor whiteColor] BackGroundColor:[UIColor orangeColor] font:16 cornerRadius:15];
    [loginButtoin addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButtoin];

    //创建注册按钮
    WHButton *registButtoin = [[WHButton alloc]initWithFrame:CGRectMake(loginX,CGRectGetMaxY(loginButtoin.frame)+space, loginW, loginH)];
    [registButtoin setButtonTitle:@"立即注册" TitleColor:[UIColor orangeColor] BackGroundColor:[UIColor clearColor] font:15 cornerRadius:15];
    [registButtoin addTarget:self action:@selector(registButtoinAction:) forControlEvents:UIControlEventTouchUpInside];
    [registButtoin setBornerWidth:1 color:[UIColor orangeColor]];
    //按钮的外框和外框颜色
    [self.view addSubview:registButtoin];
    
    
    
    
    
    //创建忘记密码
    CGSize badgeSize = [@"忘记密码?" sizeWithFont:[UIFont systemFontOfSize:11]];
    CGFloat forgetX = CGRectGetMaxX(registButtoin.frame)-badgeSize.width;
    WHButton *forgetButton = [[WHButton alloc]initWithFrame:CGRectMake(forgetX,CGRectGetMaxY(registButtoin.frame)+space,badgeSize.width, loginH/2)];
    [forgetButton setButtonTitle:@"忘记密码?" TitleColor:[UIColor grayColor] BackGroundColor:[UIColor clearColor] font:11 cornerRadius:0];
    [forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    
    
    //创建下划线
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(loginX, CGRectGetMinY(loginButtoin.frame)-space, loginW, 1)];
    downLine.backgroundColor = [UIColor grayColor];
    downLine.alpha = 0.3;
    [self.view addSubview:downLine];
    
    //创建textField 密码
    WHTextField *downField = [[WHTextField alloc]initWithFrame:CGRectMake(loginX,CGRectGetMinY(downLine.frame)-5-loginH, loginW, loginH)];
    [downField setField:@"密码" backGroundColor:[UIColor clearColor] imageName:@"password"];
    [self.view addSubview:downField];
    downField.secureTextEntry = YES;
    self.messageField = downField;
    
    //创建上划线
    UIView *upLine = [[UIView alloc]initWithFrame:CGRectMake(loginX, CGRectGetMinY(downField.frame)-space, loginW, 1)];
    upLine.backgroundColor = [UIColor grayColor];
    upLine.alpha = 0.3;
    [self.view addSubview:upLine];
    
    
    //创建textField 手机号
    WHTextField *upField = [[WHTextField alloc]initWithFrame:CGRectMake(loginX,CGRectGetMinY(upLine.frame)-5-loginH, loginW, loginH)];
    [upField setField:@"手机" backGroundColor:[UIColor clearColor] imageName:@"user2"];
    [self.view addSubview:upField];
    upField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField = upField;
}

@end
