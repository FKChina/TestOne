//
//  WHButton.m
//  登录注册
//
//  Created by 杭州信配 on 16/3/29.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import "WHButton.h"

@implementation WHButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)setButtonTitle:(NSString *)title TitleColor:(UIColor *)titleColor BackGroundColor:(UIColor *)backGroundColor font:(int)font cornerRadius:(int)radius{
    
    [self setTitle:title forState:UIControlStateNormal];
    self.font = [UIFont systemFontOfSize:font];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setBackgroundColor:backGroundColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    
}


- (void)setBornerWidth:(int)width color:(UIColor *)color{
    self.layer.borderColor  = color.CGColor;
    self.layer.borderWidth = width;
}
@end
