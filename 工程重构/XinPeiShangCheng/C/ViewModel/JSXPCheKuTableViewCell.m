//
//  JSXPCheKuTableViewCell.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPCheKuTableViewCell.h"

@implementation JSXPCheKuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cheXingLabel.adjustsFontSizeToFitWidth = YES;
    
    self.chePaiLabel.adjustsFontSizeToFitWidth = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
