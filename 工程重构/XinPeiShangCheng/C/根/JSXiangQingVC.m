//
//  JSXiangQingVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/21.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXiangQingVC.h"

@interface JSXiangQingVC ()
{
    BOOL _isAppear;
}

@property (weak, nonatomic) IBOutlet UIImageView *taoCanImage;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;

@end

@implementation JSXiangQingVC




//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (! _isAppear)
    {
        self.view.frame = CGRectMake(0 ,0, SCREEN_WIDTH , SCREEN_HEIGHT+TABBAR_HEIGHT);
    }
    _isAppear =YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}
//内存告警
#pragma mark
#pragma mark -MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//用户界面
#pragma mark
#pragma mark -UI
-(void)configUI
{
    if ([self.xiangQingType isEqualToString:@"0"])
    {
        [self showZhiXiang];
    }else if ([self.xiangQingType isEqualToString:@"1"])
    {
        [self showZhiXin];
    }else if ([self.xiangQingType isEqualToString:@"2"])
    {
        [self showZhiShang];
    }
}


//数据处理
#pragma mark
#pragma mark -Data

-(void)loadData
{
    //    获取内容视图数据
    NSDictionary * neiRongDic = @{@"actionname":@"setmealpicurl_get"};
    [[NET new]getPictureWithDic:neiRongDic CompelementHandle:^(id data) {
        NSArray * arr = data;
        if ([self.xiangQingType isEqualToString:@"0"])
        {
            JSNeiRongModel * model = arr[0];
            [_taoCanImage sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"未上传"]];
        }else if ([self.xiangQingType isEqualToString:@"1"])
        {
            JSNeiRongModel * model = arr[1];
            [_taoCanImage sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"未上传"]];
        }else if ([self.xiangQingType isEqualToString:@"2"])
        {
            JSNeiRongModel * model = arr[2];
            [_taoCanImage sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"未上传"]];
        }
    }];

}

//逻辑功能
#pragma mark
#pragma mark -Function

/**
 *展示至享组合
 */
-(void)showZhiXiang
{
//    [_taoCanImage setImage:[UIImage imageNamed:@""]];
    _labelOne.text = @"1.致享组合598组合 299元/次，买二送二（相当于149元/次）包含2年4次免费保养，含机油、机油滤芯、工时费\n2.自购买之日起2年内有效\n3.机油为英国全进口原料赞慕机油半合成10W40 SN级\n4.机滤为信配品牌高品质进口滤纸机滤\n5.修理厂网点由您任选。";
    _labelTwo.text = @"1.本组合包含每次保养4L机油，超出部分到店后另付\n2.本组合适用于车价20万以下车型。 ";
    _labelThree.text =@"1.购买成功后可以在系统中看到已购买组合使用详情\n2.到门店第一次使用组合时获得车主保养消费券\n3.保养券上方编码和刮开涂层后获得的验证码需在保养时提供给修理厂前台。";
}
/**
 *展示至信组合
 */
-(void)showZhiXin
{
    //    [_taoCanImage setImage:[UIImage imageNamed:@""]];
    _labelOne.text = @"1.致信组合898组合 449元/次，买二送二（相当于224元/次）包含2年4次免费保养，含机油、机油滤芯、工时费\n2.自购买之日起2年内有效\n3.机油为英国全进口原料赞慕机油全合成5W30/5W40 SN级\n4.机滤为信配品牌高品质进口滤纸机滤\n5.修理厂网点由您任选。";
    _labelTwo.text = @"1.本组合包含每次保养4L机油，超出部分到店后另付\n2.本组合适用于车价20万到50万车型。 ";
    _labelThree.text =@"1.购买成功后可以在系统中看到已购买组合使用详情\n2.到门店第一次使用组合时获得车主保养消费券\n3.保养券上方编码和刮开涂层后获得的验证码需在保养时提供给修理厂前台。";
}
/**
 *展示至尚组合
 */
-(void)showZhiShang
{
    //    [_taoCanImage setImage:[UIImage imageNamed:@""]];
    _labelOne.text = @"1.致尚组合1498组合 749元/次，买二送二（相当于374元/次）包含2年4次免费保养，含机油、机油滤芯、工时费\n2.自购买之日起2年内有效\n3.机油为英国全进口原料赞慕机油全合成0W40 SN级\n4.机滤为信配品牌高品质进口滤纸机滤\n5.修理厂网点由您任选。";
    _labelTwo.text = @"1.本组合包含每次保养6L机油，超出部分到店后另付\n2.本组合适用于车价50万以上车型。 ";
    _labelThree.text =@"1.购买成功后可以在系统中看到已购买组合使用详情\n2.到门店第一次使用组合时获得车主保养消费券\n3.保养券上方编码和刮开涂层后获得的验证码需在保养时提供给修理厂前台。";
}


//订购按钮点击
-(IBAction)subscribeClicked:(UIButton *)btn
{
//    [self isLoginSkipToWithJSViewControllers:ViewControllerENUM];
}
//代理区域
#pragma mark
#pragma mark -Delegate

//三方工具
#pragma mark
#pragma mark -Third-Party


@end
