//
//  WHTextField.m
//  登录注册
//
//  Created by 杭州信配 on 16/3/29.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import "WHTextField.h"

@implementation WHTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)setField:(NSString *)placeholder backGroundColor:(UIColor *)backgroundColor imageName:(NSString *)imageName {
    self.placeholder = placeholder;
    self.backgroundColor = [UIColor clearColor];
    UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(0,10,20,20)];
    [image setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    UIView *backView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0,40, self.frame.size.height)];
    [backView addSubview:image];
    self.leftView = backView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode =  UITextFieldViewModeWhileEditing;
}

@end
