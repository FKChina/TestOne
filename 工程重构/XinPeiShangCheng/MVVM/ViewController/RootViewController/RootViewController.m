
#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
}
//内存告警
#pragma mark
#pragma mark -MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//用户界面
#pragma mark
#pragma mark -UI
-(void)configUI
{
    self.tabBar.selectedImageTintColor = XINPEI_COLOR;
    
    NSArray * controllers = @[[[ZhuYeVC alloc]init],
                              [[ChaoZhiTableViewController alloc]init],
                              [[JSYuYueVC alloc]init],
                              [[WangDianVC alloc]init],
                              [[JSWoVC alloc]init]];
    NSMutableArray * rootControllers = [NSMutableArray new];
    NSArray * titleArr = @[@"主页",@"超值",@"预约",@"网点",@"我们"];
    NSArray * imageArr = @[@"tabbar_icon_normal_1",@"tabbar_icon_normal_2",@"tabbar_icon_normal_3",@"tabbar_icon_normal_4",@"tabbar_icon_normal_5"];
    NSArray * selecteImagedArr = @[@"tabbar_icon_selected_1",@"tabbar_icon_selected_2",@"tabbar_icon_selected_3",@"tabbar_icon_selected_4",@"tabbar_icon_selected_5"];
    for (int i = 0; i < controllers.count; i ++) {
        JSNavigationController * viewController = [[JSNavigationController alloc]initWithRootViewController:controllers[i]];
        viewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selecteImagedArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [rootControllers addObject:viewController];
    }
    
    self.viewControllers = rootControllers;
}
//数据处理
#pragma mark
#pragma mark -Data

//逻辑功能
#pragma mark
#pragma mark -Function

//界面跳转
#pragma mark
#pragma mark -Push

//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party
@end
