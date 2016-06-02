//
//  JSDiTuVC.h
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/25.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@protocol JSDiTuVCDelegate <NSObject>

@optional
- (void)sendVaules:(NSArray *)array;

@end

@interface JSDiTuVC : JSBaseViewController

@property (assign, nonatomic) id<JSDiTuVCDelegate>delegate;


@end
