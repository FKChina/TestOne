//
//  JSXPNoLoginView.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPNoLoginView.h"




@implementation JSXPNoLoginView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self creatBackImageWithFrame:frame];
        [self creatLoginBtn];
        
    }
    return self;
}

-(void)creatLoginBtn
{
    CGFloat btnWidth = 100;
    CGFloat btnHeight = 40;
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(self.frame.size.width/2 - btnWidth/2 , self.frame.size.height/2 - btnHeight/2 , btnWidth, btnHeight);
    self.loginBtn.layer.cornerRadius = btnHeight/2;
    self.loginBtn.layer.masksToBounds = YES;
//    self.loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
//    self.loginBtn.layer.borderWidth = 2;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = XINPEI_COLOR;
    [self addSubview:self.loginBtn];
}


-(void)creatBackImageWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-4_"]];
    image.frame = frame;
    [self addSubview:image];
}

@end
