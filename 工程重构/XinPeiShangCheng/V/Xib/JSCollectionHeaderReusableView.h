//
//  JSCollectionHeaderReusableView.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/14.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCollectionHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *ADView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArr;

@end
