//
//  JSYuYueTableViewCell.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/15.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSPhoneBtn.h"
typedef enum{
    CellTypeWeiYuYue = 0,
    CellTypeYiShiYongAndYiYuYue
} CellType;

@interface JSYuYueTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *taoCanLabeL;
@property (weak, nonatomic) IBOutlet UILabel *yanZhengLabeL;
@property (weak, nonatomic) IBOutlet UILabel *yuYueLabeL;
@property (weak, nonatomic) IBOutlet UILabel *shiYongLabeL;

@property (weak, nonatomic) IBOutlet JSPhoneBtn *yuYueBtn;
@property (weak, nonatomic) IBOutlet UILabel *xiuLiChang;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *shiJian;


+(instancetype)loadXibWithCellType:(CellType)cellType;

@end
