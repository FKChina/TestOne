//
//  ADLBView.h
//  day15-03-广告轮播封装
//
//  Created by Aaron on 15/10/23.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLBView : UIView

@property (nonatomic,assign) UIEdgeInsets boardWidth;
@property (nonatomic,strong) UIColor *boardColor;

/**
 *传入大小frame
 *图片组
 *返回滚动的视图
 */
-(instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images withTitle:(NSArray *)title withCallBack:(void(^)(NSInteger chooseIndex))callBack;
@end
