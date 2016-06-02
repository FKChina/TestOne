//
//  JSWangDianCell.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/2.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSWangDianCell.h"

@implementation JSWangDianCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.labelOne.adjustsFontSizeToFitWidth = YES;
    self.labelOne.numberOfLines = 0;
    self.labelOne.textColor = XINPEI_COLOR;
    self.labelTwo.adjustsFontSizeToFitWidth = YES;
    self.labelTwo.numberOfLines = 0;
    self.labelfour.adjustsFontSizeToFitWidth = YES;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
