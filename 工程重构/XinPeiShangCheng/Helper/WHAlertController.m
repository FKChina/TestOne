//
//  WHAlertController.m
//  登录注册
//
//  Created by 杭州信配 on 16/3/31.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import "WHAlertController.h"

@interface WHAlertController ()

@end

@implementation WHAlertController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setAlertShowWithTitle:(NSString *)title message:(NSString *)message target:(id)target
{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alterController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        
    }
                                ]];
    [target presentViewController:alterController animated:YES completion:nil];
}

@end
