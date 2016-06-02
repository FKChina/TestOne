//
//  JSTianJiaZiMuTableViewCell.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/16.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSTianJiaZiMuTableViewCell.h"

@implementation JSTianJiaZiMuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ziMuLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
