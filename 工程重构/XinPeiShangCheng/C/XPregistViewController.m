//
//  XPregistViewController.m
//  登录注册
//
//  Created by 杭州信配 on 16/3/29.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import "XPregistViewController.h"
#import "WHButton.h"


#import "NET.h"
#import "UserModelOne.h"

#define getMin [[NSUserDefaults standardUserDefaults]objectForKey:lastDay]
#define getTime [[NSUserDefaults standardUserDefaults]objectForKey:lastTime]
@interface XPregistViewController (){
    WHAlertController *vc;
    UserModelOne * _model;
}
@property(weak,nonatomic)UIView *downLine;

@property(weak,nonatomic)UITextField *downField; //手机号
@property(weak,nonatomic)UITextField *yanzhField; //验证码
@property(weak,nonatomic)UITextField *messageField; //密码

@property(weak,nonatomic)UIButton *yanzhButton;
@end

@implementation XPregistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    [self setupUI];
    vc = [[WHAlertController alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    //创建获取验证码 按钮
    CGFloat loginX = UIX;
    CGFloat loginW = winW-UIX*2;
    CGFloat loginY = self.view.center.y-UIX;
    CGFloat loginH = 5+ UIX/2;
    WHButton *loginButtoin = [[WHButton alloc]initWithFrame:CGRectMake(loginX,loginY, loginW, loginH)];
    [loginButtoin setButtonTitle:@"获取验证码" TitleColor:[UIColor orangeColor] BackGroundColor:[UIColor clearColor] font:16 cornerRadius:15];
    [loginButtoin addTarget:self action:@selector(finishRegist:) forControlEvents:UIControlEventTouchUpInside];
    loginButtoin.tag =-1;
    [loginButtoin setBornerWidth:1 color:[UIColor orangeColor]];
    [self.view addSubview:loginButtoin];
    
    //创建下划线
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(loginX, CGRectGetMinY(loginButtoin.frame)-space, loginW, 1)];
    downLine.backgroundColor = [UIColor grayColor];
    downLine.alpha = 0.3;
    [self.view addSubview:downLine];
    
    //创建textField 密码 手机号
    WHTextField *downField = [[WHTextField alloc]initWithFrame:CGRectMake(loginX,CGRectGetMinY(downLine.frame)-5-loginH, loginW, loginH)];
    [downField setField:@"手机号" backGroundColor:[UIColor clearColor] imageName:@"phone2"];
    downField.placeholder = @"手机号";
    downField.backgroundColor = [UIColor clearColor];
    UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(0,5,25,30)];
    [image setBackgroundImage:[UIImage imageNamed:@"phone2"] forState:UIControlStateNormal];
    UIView *backView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0,40, downField.frame.size.height)];
    [backView addSubview:image];
    downField.leftView = backView;
    downField.leftViewMode = UITextFieldViewModeAlways;
    downField.clearButtonMode =  UITextFieldViewModeWhileEditing;
    [self.view addSubview:downField];
    self.downLine = downLine;
    self.downField = downField;
}


//点击获得验证码 的 按钮
- (void)finishRegist:(UIButton *)button{
    //判断是否是手机号
    if([XPJudgePhoneNumber valiMobile:self.downField.text]){
        //其次判断是否 在哪个模式是否注册过
        [self judgephoneNumber:^(id WayValue) {
            if([WayValue isEqualToString:@"yes"]){
                //移除获取验证码
                for(UIView *view in self.view.subviews){
                    if(view.tag==-1){
                        [view removeFromSuperview];
                    }
                }
                [self setupMoreUI];
            }
        }];
    }
    else{
        [vc setAlertShowWithTitle:@"温馨提示" message:@"手机号错误" target:self];
    }
    
}


//点击 立即注册 按钮
- (void)finishButtonAction:(UIButton *)button{
    if(self.choice==1){  //注册
        if([self.messageField.text length]<6){
             [vc setAlertShowWithTitle:@"温馨提示" message:@"密码小于6位" target:self];
        }
        else{
            NSMutableDictionary * netDic = [NSMutableDictionary new];
            NSMutableString * telStr = [NSMutableString stringWithString:self.downField.text];
            NSMutableString * userpwdStr = [NSMutableString stringWithString:self.messageField.text];
            NSMutableString * captcha = [NSMutableString stringWithString:self.yanzhField.text];
            [netDic setObject:telStr forKey:@"tel"];
            [netDic setObject:@"user_registe" forKey:@"actionname"];
            [netDic setObject:userpwdStr forKey:@"userpwd"];
            [netDic setObject:captcha forKey:@"captcha"];
            //上传服务器 验证
            [WHNetWorking operationManagerGET:RootLocation parameters:netDic WithReturnValeuBlock:^(id returnValue) {
                NSDictionary *dict = returnValue;
                NSString *key = [NSString stringWithFormat:@"%@",[dict[@"result"]objectForKey:@"key"]];
                NSLog(@"%@",returnValue);
                if([key isEqualToString:@"1"]){  //修改成功
                    [MBProgressHUD showSuccess:@"注册成功"];
                    
//                    注册成功之后获取用户数据
                    
                    NSMutableDictionary * userDic = [NSMutableDictionary new];
                    [userDic setObject:telStr forKey:@"UserName"];
                    [userDic setObject:userpwdStr forKey:@"PWD"];
                    
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        延迟函数内部
                        [MBProgressHUD hideHUD];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }
                else{   //修改失败
                    [vc setAlertShowWithTitle:@"温馨提示" message:@"信息填写错误" target:self];
                }
            } WithErrorCodeBlock:^(id errorCode) {
                [vc setAlertShowWithTitle:@"温馨提示" message:@"网络故障" target:self];
            } WithFailureBlock:^(id failureCode) {
                [vc setAlertShowWithTitle:@"温馨提示" message:@"网络故障" target:self];
            }];

        }
    }
    else{ //修改密码
        if([self.messageField.text length]<6){
            [vc setAlertShowWithTitle:@"温馨提示" message:@"密码小于6位" target:self];
            }
        else{
            //上传服务器 验证
            //将本地数据变成文件体--字典
            NSMutableDictionary * netDic = [NSMutableDictionary new];
            NSMutableString * userpwd = [NSMutableString stringWithString:self.messageField.text];
            NSMutableString * captcha = [NSMutableString stringWithString:self.yanzhField.text];
            NSMutableString * tel = [NSMutableString stringWithString:[self refreshNSString:self.downField.text]];
            [netDic setObject:@"user_uspdatepwd" forKey:@"actionname"];
            [netDic setObject:userpwd forKey:@"userpwd"];
            [netDic setObject:captcha forKey:@"captcha"];
            [netDic setObject:tel forKey:@"tel"];
            [WHNetWorking operationManagerGET:RootLocation parameters:netDic WithReturnValeuBlock:^(id returnValue) {
                NSDictionary *dict = returnValue;
                NSString *key = [NSString stringWithFormat:@"%@",[dict[@"result"]objectForKey:@"key"]];
                if([key isEqualToString:@"1"]){  //修改成功
                    [MBProgressHUD showSuccess:@"修改成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //延迟函数内部
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                else{   //修改失败
                    [vc setAlertShowWithTitle:@"温馨提示" message:@"信息填写错误" target:self];
                }
            } WithErrorCodeBlock:^(id errorCode) {
                [vc setAlertShowWithTitle:@"温馨提示" message:@"网络故障" target:self];
            } WithFailureBlock:^(id failureCode) {
                [vc setAlertShowWithTitle:@"温馨提示" message:@"网络故障" target:self];
            }];
            
        }
    }
    
}

//添加更多UI控件
- (void)setupMoreUI{
    CGFloat loginX = UIX;
    CGFloat loginW = winW-UIX*2;
    CGFloat loginY = self.view.center.y-UIX;
    CGFloat loginH = 5+ UIX/2;
    //动画
    [UIView animateWithDuration:1.0 animations:^{
        //创建textField 短信验证码
        WHTextField *yanzh = [[WHTextField alloc]initWithFrame:CGRectMake(loginX,CGRectGetMinY(self.downLine.frame)+space, loginW, loginH)];
        [yanzh setField:@"短信验证码" backGroundColor:[UIColor clearColor] imageName:@"yanzhma"];
        [self.view addSubview:yanzh];
        self.yanzhField = yanzh;
        //创建下划线
        WHView *yanzhdownLine = [[WHView alloc]initWithFrame:CGRectMake(loginX, CGRectGetMaxY(yanzh.frame)+5, loginW, 1)];
        [self.view addSubview:yanzhdownLine];
        
        //创建textField 登录密码
        WHTextField *message = [[WHTextField alloc]initWithFrame:CGRectMake(loginX,CGRectGetMaxY(yanzh.frame)+space+1, loginW, loginH)];
        if(self.choice==1){
            [message setField:@"设置登录密码(至少六位)" backGroundColor:[UIColor clearColor] imageName:@"password"];
        }
        else{
            [message setField:@"重设密码(至少六位)" backGroundColor:[UIColor clearColor] imageName:@"password"];
        }
        [self.view addSubview:message];
        self.messageField = message;
        
        //创建下划线
        WHView *dengludownLine = [[WHView alloc]initWithFrame:CGRectMake(loginX, CGRectGetMaxY(message.frame)+5, loginW, 1)];
        [self.view addSubview:dengludownLine];
        
        //立即注册按钮
        WHButton *loginButtoin = [[WHButton alloc]initWithFrame:CGRectMake(loginX,CGRectGetMinY(dengludownLine.frame)+space, loginW, loginH)];
        if(self.choice==1){
            [loginButtoin setButtonTitle:@"立即注册" TitleColor:[UIColor whiteColor] BackGroundColor:[UIColor orangeColor] font:16 cornerRadius:15];
        }
        else{
            [loginButtoin setButtonTitle:@"修改密码" TitleColor:[UIColor whiteColor] BackGroundColor:[UIColor orangeColor] font:16 cornerRadius:15];
        }
        [loginButtoin addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginButtoin];
        
        //倒计时按钮
        WHButton *getYanzhma = [[WHButton alloc]initWithFrame:CGRectMake(loginX,CGRectGetMaxY(loginButtoin.frame)+space, loginW, loginH)];
        [getYanzhma setButtonTitle:@"获取验证码" TitleColor:[UIColor orangeColor] BackGroundColor:[UIColor clearColor] font:16 cornerRadius:15];
        [getYanzhma addTarget:self action:@selector(daojishi) forControlEvents:UIControlEventTouchUpInside];
        [getYanzhma setBornerWidth:1.0 color:[UIColor orangeColor]];
        [self.view addSubview:getYanzhma];
        self.yanzhButton = getYanzhma;
        [self daojishi];
    }];
}

//点击按钮触发的倒计时方法
- (void)daojishi{

    //请求验证码 前 判断是否 需要申请 验证码

    if(getMin==nil || [getMin isEqualToString:@""] || (getMin!=nil &&[TimeCalculator intervalFromLastDate:getMin toTheDate:@"1"]>=MAXMinute)){
        //可以申请
        [self getSureMessage];
        
        [[NSUserDefaults standardUserDefaults]setObject:[TimeCalculator getTheDay] forKey:lastDay];
        
             [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:lastTime];

        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    //
    else if([TimeCalculator intervalFromLastDate:getMin toTheDate:@"1"]<MAXMinute && [getTime intValue]<MAXTime){
        //可以申请
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%i",[getTime intValue]+1] forKey:lastTime];
         [[NSUserDefaults standardUserDefaults]synchronize];
        [self getSureMessage];
    }
    else{
            //不可以申请
        [vc setAlertShowWithTitle:@"温馨提示" message:@"请勿重复操作发送验证码,如需帮助请联系客服" target:self];
    }
}

//成功获取验证码
- (void)getSureMessage{
    [MBProgressHUD showSuccess:@"已发送"];
    NSDictionary *dict = @{@"actionname":@"user_captcha",@"tel":self.downField.text};
    [WHNetWorking operationManagerGET:RootLocation parameters:dict WithReturnValeuBlock:^(id returnValue) {
        
    } WithErrorCodeBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureCode) {
        
    }];
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.yanzhButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.yanzhButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.yanzhButton setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.yanzhButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



//判断验证码
- (void)judgephoneNumber:(WayValueBlock)wayValue{
    //首先判断是否需要验证码
    NSDictionary *dict = @{@"actionname":@"checkexistsphone",@"tel":self.downField.text};
    [WHNetWorking operationManagerGET:RootLocation parameters:dict WithReturnValeuBlock:^(id returnValue) {
        NSDictionary *dict = returnValue;
        if([[dict objectForKey:@"statecode"]isEqualToString:@"0"]){ //手机号被使用过
            if(self.choice==1){  // 注册
                [vc setAlertShowWithTitle:@"温馨提示" message:@"该手机已注册" target:self];
                wayValue(@"no");
            }
            else{  //忘记密码
                wayValue(@"yes");
            }
        }
        else{  //手机号没有被使用过
            if(self.choice==1){  // 注册
                wayValue(@"yes");
            }
            else{  //忘记密码
                [vc setAlertShowWithTitle:@"温馨提示" message:@"输入的手机号没有被注册过" target:self];
                wayValue(@"no");
            }
        }
    } WithErrorCodeBlock:^(id errorCode) {
    } WithFailureBlock:^(id failureCode) {
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (NSString *)refreshNSString:(NSString *)string{
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}

@end
