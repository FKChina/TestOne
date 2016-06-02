//
//  JSBaseLabel.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSBaseLabel : UILabel
/**
 *  自定义标签
 *
 *  @param title           标签内容
 *  @param titleColor      颜色
 *  @param backGroundColor 背景色
 *  @param font            大小
 *  @param radius          边角
 *  @param boardSize       边框大小
 *  @param boardColor      边框颜色
 */
- (void)setLabelTitle:(NSString *)title TitleColor:(UIColor *)titleColor BackGroundColor:(UIColor *)backGroundColor font:(int)font cornerRadius:(int)radius boardSize:(int)boardSize boardColor:(UIColor *)boardColor textAlignment:(NSTextAlignment)nsTextAlignment;
@end
