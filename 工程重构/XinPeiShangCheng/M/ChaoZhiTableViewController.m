//
//  ChaoZhiTableViewController.m
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "ChaoZhiTableViewController.h"

//定义cell标识

static NSString * const identifier = @"bargainCell";


@interface ChaoZhiTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _neiRongArr;    //页面内容数据源
    CGFloat  _height;         //footsection高度
    BOOL _isAppear;
}


//@property (weak, nonatomic) IBOutlet UITableView *zuHeTabelView;

//@property (weak, nonatomic) IBOutlet UIButton *dingGouBtn;//订购按钮

@end

@implementation ChaoZhiTableViewController


//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
/**
 *视图将要画好时
 */
- (void)viewWillLayoutSubviews
{
    
//    [super viewWillLayoutSubviews];
//    //    判断上层控制器
//    if (! _isAppear)
//    {
//        self.view.frame = CGRectMake(0 ,0, SCREEN_WIDTH , SCREEN_HEIGHT );
//    }
//    _isAppear =YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refrashNavigationBar];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIButton * paybtn = [UIButton buttonWithType:UIButtonTypeSystem];
    paybtn.frame = CGRectMake(100, 100, 100, 100);
    [paybtn setTitle:@"支付" forState:UIControlStateNormal];
    [paybtn addTarget:self action:@selector(payforAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paybtn];
//    [self.juHua startAnimating];
//    [self configUI];
//    [self headerRereshing];
//    [self.zuHeTabelView.mj_header beginRefreshing];
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
    
//    [_dingGouBtn addTarget:self action:@selector(subscribeClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    _height = 0;
//    _zuHeTabelView.delegate = self;
//    _zuHeTabelView.dataSource = self;
//    _zuHeTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_zuHeTabelView registerNib:[UINib nibWithNibName:@"BargainViewCell" bundle:nil] forCellReuseIdentifier:identifier];
}
//数据处理
#pragma mark
#pragma mark -Data
-(void)loadData
{
//    //    获取内容视图数据
//    NSDictionary * neiRongDic = @{@"actionname":@"setmealpicurl_get"};
//    [[NET new]getPictureWithDic:neiRongDic CompelementHandle:^(id data) {
//        _neiRongArr = data;
//        _height = 60;
//        [self.zuHeTabelView.mj_header endRefreshing];
//        [_zuHeTabelView reloadData];
//    }];
//    //延时十秒判断数据源是否为空
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.zuHeTabelView.mj_header endRefreshing];
//            [_zuHeTabelView reloadData];
//    });
}
//逻辑功能
#pragma mark
#pragma mark -Function



- (IBAction)payforAction:(id)sender {
    
    
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
    
    
    
//    [AlipayRequestConfig alipayWithPartner:@"asdadad" seller:@"asdasdasda" tradeNO:[AlipayToolKit genTradeNoWithTime] productName:@"asdfas" productDescription:@"asdafasfa" amount:@"0.01" notifyURL:@"asdasfafgasd"];
}

//订购按钮点击
-(IBAction)subscribeClicked:(UIButton *)btn
{
    if (_neiRongArr == nil || _neiRongArr.count == 0) {
        [self loadData];
    }else
    {
//        [self isLoginSkipToWithJSViewControllers:ViewControllerENUM];
    }
}

//代理区域
#pragma mark
#pragma mark -Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _neiRongArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BargainViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    JSNeiRongModel * model = _neiRongArr[indexPath.row];
    [cell.imageForBargain sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"未上传"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSXiangQingVC * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JSXiangQingVC"];
    [self.navigationController pushViewController:XQVC animated:YES];
    XQVC.xiangQingType = [NSString stringWithFormat:@"%ld",indexPath.row];
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
    [header setTitle:@"刷新套餐数据！" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新!" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中……" forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    header.stateLabel.textColor = XINPEI_COLOR;
    header.lastUpdatedTimeLabel.textColor = XINPEI_COLOR;
//    self.zuHeTabelView.mj_header = header;
}

@end
