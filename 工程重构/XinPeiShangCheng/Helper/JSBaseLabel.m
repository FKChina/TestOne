//
//  JSBaseLabel.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSBaseLabel.h"

@implementation JSBaseLabel


- (void)setLabelTitle:(NSString *)title TitleColor:(UIColor *)titleColor BackGroundColor:(UIColor *)backGroundColor font:(int)font cornerRadius:(int)radius boardSize:(int)boardSize boardColor:(UIColor *)boardColor textAlignment:(NSTextAlignment)nsTextAlignment
{
    self.text = title;
    self.textAlignment = nsTextAlignment;
    self.textColor = titleColor;
    self.backgroundColor = backGroundColor;
    self.font = [UIFont systemFontOfSize:font];
    self.layer.cornerRadius = radius;
    self.adjustsFontSizeToFitWidth = YES;
    self.layer.borderWidth = boardSize;
    self.layer.backgroundColor = boardColor.CGColor;
}

@end
