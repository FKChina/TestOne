//
//  WHButton.h
//  登录注册
//
//  Created by 杭州信配 on 16/3/29.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHButton : UIButton

- (void)setButtonTitle:(NSString *)title TitleColor:(UIColor *)titleColor BackGroundColor:(UIColor *)backGroundColor font:(int)font cornerRadius:(int)radius;
- (void)setBornerWidth:(int)width color:(UIColor *)color;

@end
