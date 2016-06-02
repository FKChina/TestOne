//
//  JSXPCheKuTableView.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPCheKuTableView.h"
#import "JSXPCheKuTableViewCell.h"
#import "JSGeRenZhongXinViewController.h"

#define TABLEVIEW_COUNT 15
static NSString * identifierForCheKuCell = @"identifierForCheKuCell";
@interface JSXPCheKuTableView ()<UITableViewDataSource,UITableViewDelegate>

//车库数据模型
@property (nonatomic , strong) UserModelOne * model;
//当前选中的车的位置
@property (nonatomic , strong) NSIndexPath * dangQianWeiZhi;

@end

@implementation JSXPCheKuTableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        [self configUI];
        [self headerRereshing];
        [self.mj_header beginRefreshing];
    }
    return self;
}
//定义属性
#pragma mark
#pragma mark -Attribute

//初始化值
#pragma mark
#pragma mark -Init

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle

//内存告警
#pragma mark
#pragma mark -MemoryWarning

//用户界面
#pragma mark
#pragma mark -UI
-(void)configUI
{
    self.dangQianWeiZhi = [NSIndexPath new];
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"JSXPCheKuTableViewCell" bundle:nil] forCellReuseIdentifier:identifierForCheKuCell];
}
//数据处理
#pragma mark
#pragma mark -Data
-(void)loadData
{
    NSDictionary * dic = @{@"actionname":@"user_car_get",@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]};
    [[NET new]getDataWithDictionary:dic WithJSReturnDataBlock:^(id data)
    {
        if (data) {
            NSDictionary * dic = data;
            self.model = [[UserModelOne alloc]initWithDictionary:dic error:nil];
            [self reloadData];
            [self.mj_header endRefreshing];
        }
    } WithJSErrorMessageBlock:^(id errorMessage)
    {
        
    } WithJSFailureMessageBlock:^(id failureMessage)
    {
        
    }];
}
//逻辑功能
#pragma mark
#pragma mark -Function

//界面跳转
#pragma mark
#pragma mark -Push

//代理区域
#pragma mark
#pragma mark -Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JSXPCheKuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForCheKuCell forIndexPath:indexPath];
    UserCarModel * model = self.model.rows[indexPath.row];
    cell.cheXingLabel.text = model.CarName;
    cell.chePaiLabel.text = model.CarNum;
    if (indexPath == self.dangQianWeiZhi){
        [cell.selectedImageView setImage:[UIImage imageNamed:@"chose2"]];
        self.cheXing = model.CarName;
        self.chePai = model.CarNum;
    }else
    {
        [cell.selectedImageView setImage:[UIImage imageNamed:@"chose1"]];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.rows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size.height/TABLEVIEW_COUNT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.dangQianWeiZhi = indexPath;
    JSXPCheKuTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    UserCarModel * model = self.model.rows[indexPath.row];
    self.cheXing = model.CarName;
    self.chePai = model.CarNum;
    self.cheKuCarId = model.Id;
    self.carId = model.CarType;
    [cell.selectedImageView setImage:[UIImage imageNamed:@"chose2"]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSNavigationController * controller = [[JSNavigationController alloc]init];
    
    
    [controller pushViewController:[[JSGeRenZhongXinViewController alloc]init] animated:YES];
    
    
    JSXPCheKuTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.selectedImageView setImage:[UIImage imageNamed:@"chose1"]];
}




//三方工具
#pragma mark
#pragma mark -Third-Party
/**
 *下拉刷新
 */
- (void)headerRereshing
{
    MJRefreshNormalHeader * header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 设置文字
    [header setTitle:@"刷新车系数据!" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新!" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中……" forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    header.stateLabel.textColor = XINPEI_COLOR;
    header.lastUpdatedTimeLabel.textColor = XINPEI_COLOR;
    self.mj_header = header;
}
@end
