//
//  ViewController.h
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface ViewController : JSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UILabel *dangQianChePaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dangQianCheXingLabel;
@property (weak, nonatomic) IBOutlet UITableView *taoCanTabelView;
@property (weak, nonatomic) IBOutlet UIButton *xuanCheBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (copy, nonatomic) NSString  *tiaoZhuanType;//(0需要自适应，1不需要)

@end
