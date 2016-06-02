//
//  JSNavigationController.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/8.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSNavigationController.h"

@interface JSNavigationController ()

@end

@implementation JSNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];//初始化图片视图控件
    UIImage *image = [UIImage imageNamed:@"logo"];//初始化图像视图
    [imageView setImage:image];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //判断 除了根控制器 以外的控制器
    
    if(self.viewControllers.count>0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


@end
