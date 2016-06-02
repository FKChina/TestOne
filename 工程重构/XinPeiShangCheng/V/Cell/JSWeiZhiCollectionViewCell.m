//
//  JSWeiZhiCollectionViewCell.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/13.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSWeiZhiCollectionViewCell.h"

@implementation JSWeiZhiCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.label.layer.cornerRadius = 5;
    self.label.layer.masksToBounds = YES;
    self.label.adjustsFontSizeToFitWidth = YES;
}

@end
