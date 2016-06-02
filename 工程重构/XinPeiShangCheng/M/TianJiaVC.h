//
//  TianJiaVC.h
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TianJiaVC : JSBaseViewController


@property (weak, nonatomic) IBOutlet UITableView *cheXiTableView;//车系列表
@property (weak, nonatomic) IBOutlet UITableView *cheXingTableView;//车型列表
@property (weak, nonatomic) IBOutlet UITableView *paiLiangTableView;//排量列表
@property (weak, nonatomic) IBOutlet UITableView *ziMuTableView;//车型字母列表
@property (weak, nonatomic) IBOutlet UITextField *shuRuChePaiText;//车牌输入框
@property (weak, nonatomic) IBOutlet UILabel *yiXuanCheXingLabel;//车型显示框
@property (weak, nonatomic) IBOutlet UIView *cheXingView;//承载车系滑动视图
@property (weak, nonatomic) IBOutlet UIView *cheXingFuGaiView;//覆盖车系滑动视图
@property (weak, nonatomic) IBOutlet UIView *paiLiangView;//承载排量滑动视图
@property (weak, nonatomic) IBOutlet UIView *paiLiangFuGaiView;//覆盖排量滑动视图
@property (weak, nonatomic) IBOutlet UIButton *queRenBtn;//确认按钮
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;//清除按钮


@end
