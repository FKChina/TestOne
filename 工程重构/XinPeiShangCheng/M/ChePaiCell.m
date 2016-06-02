//
//  ChePaiCell.m
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/31.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "ChePaiCell.h"

@implementation ChePaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.chePaiLabel.adjustsFontSizeToFitWidth = YES;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}

@end
