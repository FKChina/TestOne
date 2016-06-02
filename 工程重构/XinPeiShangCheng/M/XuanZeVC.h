//
//  XuanZeVC.h
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>






@interface XuanZeVC : JSBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *duiYingCheXingLabel;
@property (weak, nonatomic) IBOutlet UIButton *xuanZenBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *yiYouChePai;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (copy, nonatomic) NSString * addChePiaHao;
@property (copy, nonatomic) NSString * addCheXingHao;

@property (copy, nonatomic) NSString * tiaoZhuanZhuangTai;//0代表推出这一层 1代表导航到下一层

@end
