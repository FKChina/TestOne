//
//  JSYuYueXiangQingTableViewCell.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/25.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSYuYueXiangQingTableViewCell.h"

@implementation JSYuYueXiangQingTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.xiuLiChang.adjustsFontSizeToFitWidth = YES;
    self.address.adjustsFontSizeToFitWidth = YES;
    self.juLl.adjustsFontSizeToFitWidth = YES;
    self.xiuLiChang.textColor = [UIColor orangeColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
