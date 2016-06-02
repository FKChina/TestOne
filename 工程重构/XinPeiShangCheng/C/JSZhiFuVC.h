//
//  JSZhiFuVC.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/5.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSZhiFuVC : JSBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *zhiFuJiaGeLabel;

@property (weak, nonatomic) IBOutlet UIButton *queRenAnNiu;

@property (weak, nonatomic) IBOutlet UIButton *tongYiBtn;

@property (weak, nonatomic) IBOutlet UITableView *zhiFuTable;

@property (copy, nonatomic) NSString * taoCanName;


@property (copy, nonatomic) NSString * productName;//商品名称
@property (copy, nonatomic) NSString * productDescription;//商品描述
@property (copy, nonatomic) NSString * productPrice;//商品价格

@end
