//
//  XPJSActivityIndicatorView.m
//  XinPeiShangChengVersions2
//
//  Created by 醉卧沙场君莫笑 on 16/4/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "XPJSActivityIndicatorView.h"

@implementation XPJSActivityIndicatorView

-(instancetype)initWithPoint:(CGPoint)point
{
    self = [super initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    if (self) {
        self.center = point;
        self.hidesWhenStopped = YES;
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return self;
}

@end
