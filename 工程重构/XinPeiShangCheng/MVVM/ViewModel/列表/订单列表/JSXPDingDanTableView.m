//
//  JSXPDingDanTableView.m
//  XinPeiShangCheng
//
//  Created by BankWong on 16/5/27.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPDingDanTableView.h"

#define TABLEVIEW_COUNT 15



@interface JSXPDingDanTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray * dataArr;//数据源

@end

@implementation JSXPDingDanTableView

-(instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self loadData];
        [self headerRereshing];
    }
    return self;
}

//视图周期
#pragma mark
#pragma mark View_Life_Cycle

//界面搭建
#pragma mark
#pragma mark UI
-(void)configUI
{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//数据源
#pragma mark
#pragma mark Data
/**
 *加载用户数据
 */
-(void)loadData
{
    NSMutableArray * dataArr = [NSMutableArray new];
    [[NET new]getDataWithDictionary:@{@"actionname":@"orderinfobyuid",@"Uid":[[NSUserDefaults standardUserDefaults]objectForKey:USER_UID]} WithJSReturnDataBlock:^(id data)
     {
         NSArray * arr = [data objectForKey:@"rows"];
         for (NSDictionary * dic in arr) {
             JSDingDanModelRows * model = [[JSDingDanModelRows alloc]initWithDictionary:dic error:nil];
             [dataArr addObject:model];
         }
         self.dataArr = dataArr;
         [self.mj_header endRefreshing];
         [self reloadData];
     } WithJSErrorMessageBlock:^(id errorMessage) {
         [self.mj_header endRefreshing];
         [MBProgressHUD showError:@"数据有误"];
         [self reloadData];
     } WithJSFailureMessageBlock:^(id failureMessage) {
         [self.mj_header endRefreshing];
         [MBProgressHUD showError:@"获取信息失败"];
         [self reloadData];
     }];
}
//逻辑处理
#pragma mark
#pragma mark Function

//相应事件
#pragma mark
#pragma mark Action
/**
 *点击跳转详情页面
 */
-(IBAction)yuYueBtnClicked:(JSPhoneBtn *)btn
{
    //进入预约详情
    JSYuYueXiangQingVC * VC = [[JSYuYueXiangQingVC alloc]init];
    JSNavigationController * navigationController = [[JSNavigationController alloc]init];
    [navigationController pushViewController:VC animated:YES];
    //    预约的id
    VC.yuYueId = btn.yuYueId;
    //    对应套餐名字
    VC.taoCanName = btn.phoneNumber;
}
//执行代理
#pragma mark
#pragma mark Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    JSDingDanModelRows *model = self.dataArr[indexPath.section];
    
//    JSDingDanModel * model1 = ((JSDingDanModelTable * )model.children).Table[indexPath.row];
    
//    if ([model1.yystatecode isEqualToNumber:@0] ) {
//        JSYuYueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellTypeWeiYuYue"];
//        if (!cell) {
//            cell = [JSYuYueTableViewCell loadXibWithCellType:CellTypeWeiYuYue];
//        }
//        cell.taoCanLabeL.text = model1.proname;
//        cell.yanZhengLabeL.text = model1.identifycode;
//        cell.yuYueLabeL.text = @"未预约";
//        cell.shiYongLabeL.text = @"未使用";
//        [cell.yuYueBtn addTarget:self action:@selector(yuYueBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        cell.yuYueBtn.yuYueId = [NSString stringWithFormat:@"%@",model1.id];
//        cell.yuYueBtn.phoneNumber = [NSString stringWithFormat:@"%@",model1.proname];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }else
//    {
        JSYuYueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellTypeYiShiYongAndYiYuYue"];
//        if (!cell) {
//            cell = [JSYuYueTableViewCell loadXibWithCellType:CellTypeYiShiYongAndYiYuYue];
//        }
//        cell.taoCanLabeL.text = model1.proname;
//        cell.yanZhengLabeL.text = model1.identifycode;
//        cell.shiYongLabeL.text = @"未使用";
        return cell;
//    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size.height/TABLEVIEW_COUNT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    [header setTitle:@"刷新订单信息!" forState:MJRefreshStateIdle];
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
//内存管理
#pragma mark
#pragma mark MemoryWarning


@end
