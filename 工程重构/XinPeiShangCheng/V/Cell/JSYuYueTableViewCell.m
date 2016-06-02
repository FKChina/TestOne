//
//  JSYuYueTableViewCell.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/15.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSYuYueTableViewCell.h"

@implementation JSYuYueTableViewCell


//@property (weak, nonatomic) IBOutlet UILabel *taoCanLabeL;
//@property (weak, nonatomic) IBOutlet UILabel *yanZhengLabeL;
//@property (weak, nonatomic) IBOutlet UILabel *yuYueLabeL;
//@property (weak, nonatomic) IBOutlet UILabel *shiYongLabeL;
//
//@property (weak, nonatomic) IBOutlet UILabel *isZhiFu;
//@property (weak, nonatomic) IBOutlet UILabel *xiuLiChang;
//@property (weak, nonatomic) IBOutlet UILabel *address;
//@property (weak, nonatomic) IBOutlet UILabel *shiJian;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.taoCanLabeL.adjustsFontSizeToFitWidth = YES;
    self.yanZhengLabeL.adjustsFontSizeToFitWidth = YES;
    self.yuYueLabeL.adjustsFontSizeToFitWidth = YES;
    self.shiYongLabeL.adjustsFontSizeToFitWidth = YES;
    
    self.xiuLiChang.adjustsFontSizeToFitWidth = YES;
    self.address.adjustsFontSizeToFitWidth = YES;
    self.shiJian.adjustsFontSizeToFitWidth = YES;
    
    
    self.yuYueBtn.layer.cornerRadius = 5;
    self.yuYueBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)loadXibWithCellType:(CellType)cellType
{
    return [[NSBundle mainBundle]loadNibNamed:@"JSYuYueTableViewCell" owner:nil options:nil][cellType];
}
@end
