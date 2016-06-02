//
//  JSXPWangDianTableView.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/5/26.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSXPWangDianTableView.h"


#define JSSafeString(str) (str == nil ? @"" : str)
#define LIMIT_COUNT 20
#define TABLEVIEW_COUNT 15


static NSString * identifierForWangDianViewCell = @"identifierForWangDianViewCell";
@interface JSXPWangDianTableView ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    MJRefreshAutoNormalFooter *footer;
}

//数据模型
@property (copy, nonatomic) JSBranchesModelOne * model;
//数据源
@property (copy, nonatomic) NSArray * dataArr;


/**  定位管理者  */
@property (nonatomic, strong) CLLocationManager *locManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
//纬度
@property (copy, nonatomic) NSString * latitude;
//经度
@property (copy, nonatomic) NSString * longitude;
//第几页
@property (assign, nonatomic) NSInteger page;


@end

@implementation JSXPWangDianTableView


//懒加载
- (CLLocationManager *)locManager
{
    if (!_locManager) {
        _locManager = [[CLLocationManager alloc] init];
        self.locManager.distanceFilter = 10;
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locManager.delegate = self;
    }
    return _locManager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        [self configUI];
        //    添加下拉刷新
        [self headerRereshing];
        
        //判断是否可以定位
        if ([self locationCurrent])
        {
            //        开始定位
            [self.locManager startUpdatingLocation];
        }else
        {
            //        提示设置权限
            [MBProgressHUD showError:@"请设置定位权限！"];
        }
        
        
        
//        [self headerRereshing];
//        [self.mj_header beginRefreshing];
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
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"JSWangDianCell" bundle:nil] forCellReuseIdentifier:identifierForWangDianViewCell];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//数据处理
#pragma mark
#pragma mark -Data
-(void)loadNewData
{
    
    
    
    //    第一次加载数据
    if (_latitude.length != 0 && _latitude !=nil && _longitude.length != 0 && _longitude !=nil) {
        //    第一次加载数据
        _page = 0;
        NSDictionary * dic = @{@"actionname":@"getxlcinfobyaddress",@"limit":[NSString stringWithFormat:@"%d",LIMIT_COUNT],@"pageIndex":[NSString stringWithFormat:@"%ld",_page],@"latitude":_latitude,@"longitude":_longitude};
        //    发送网络请求
        [[NET new]getDataWithDic:dic CompelementHandle:^(id data)
         {
             _model = data;
             _dataArr = _model.rows;
             //         列表刷新
             [self reloadData];
             //         添加上拉加载更多数据
             [self footerRereshing];
             //         下拉刷新结束
             [self.mj_header endRefreshing];
             //         判断数据量
             if (_model.rows.count < LIMIT_COUNT) {
                 // 变为没有更多数据的状态
                 [footer endRefreshingWithNoMoreData];
             }
         }];
    }else
    {
        [MBProgressHUD showError:@"请进行定位之后再刷新!"];
        [self.mj_header endRefreshing];
    }
}


-(void)loadMoreData
{
    
    
    //    第一次加载数据
    
    if (_latitude.length != 0 && _latitude !=nil && _longitude.length != 0 && _longitude !=nil) {
        //    加载更多数据
        ++_page;
        //    下一页
        NSDictionary * dic = @{@"actionname":@"getxlcinfobyaddress",@"limit":[NSString stringWithFormat:@"%d",LIMIT_COUNT],@"pageIndex":[NSString stringWithFormat:@"%ld",_page],@"latitude":_latitude,@"longitude":_longitude};
        //    发送请求
        [[NET new]getDataWithDic:dic CompelementHandle:^(id data)
         {
             _model = data;
             //        将更多数据添加到数组
             NSMutableArray * arr = [[NSMutableArray alloc]initWithArray:_dataArr];
             for (JSBranchesModelRows * model  in _model.rows) {
                 [arr addObject:model];
             }
             //        更新数据源
             _dataArr = arr;
             //        刷新列表
             [self reloadData];
             //        结束上拉加载
             [self.mj_footer endRefreshing];
             //        判断数据量
             if (_model.rows.count < LIMIT_COUNT) {
                 // 变为没有更多数据的状态
                 [footer endRefreshingWithNoMoreData];
             }
         }];
    }else
    {
        [MBProgressHUD showError:@"请进行定位之后再刷新!"];
        [self.mj_header endRefreshing];
    }
}

//逻辑功能
#pragma mark
#pragma mark -Function
/**
 *判断授权状态
 *
 *返回 YES 允许
 *返回 NO  不允许
 */
- (BOOL)locationCurrent
{
    //判断授权状态
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    [self.locManager startUpdatingLocation];
    if (status == kCLAuthorizationStatusNotDetermined)
    {//不允许
        return NO;
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {//总是或者使用中
        return YES;
    }else
    {//其余
        return NO;
    }
}

/**
 *下拉刷新
 */
- (void)headerRereshing
{
    MJRefreshNormalHeader * header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    [header setTitle:@"刷新附近修理厂数据！" forState:MJRefreshStateIdle];
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
/**
 *上拉加载
 */
- (void)footerRereshing
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置文字
    [footer setTitle:@"加载中……" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"当前位置附近没有更多修理厂！" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    // 设置颜色
    footer.stateLabel.textColor = XINPEI_COLOR;
    // 设置尾部
    self.mj_footer = footer;
}



/**
 *反编码获取当前地理位置，并显示
 */
-(IBAction)dingWei:(UIButton *)btn
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[_latitude doubleValue] longitude:[_longitude doubleValue]];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             //            反编码失败
             self.loaction = JSSafeString(@"您确定还在地球上吗?");
         }
         //        反编码成功，显示数据在界面
         for (CLPlacemark *placemark in placemarks)
         {
             NSDictionary *dict = placemark.addressDictionary;
             NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                                  JSSafeString(placemark.administrativeArea),
                                  JSSafeString(placemark.subAdministrativeArea),
                                  JSSafeString(placemark.locality),
                                  JSSafeString(placemark.subLocality),
                                  JSSafeString(placemark.thoroughfare),
                                  JSSafeString(placemark.subThoroughfare)];
             if (address.length == 0)
             {
                 address = [NSString stringWithFormat:@"%@%@",
                            [dict objectForKey:@"Country"],
                            [dict objectForKey:@"Name"]];
             }
             self.loaction = address;
         }
     }];
}

//界面跳转
#pragma mark
#pragma mark -Push

//代理区域
#pragma mark
#pragma mark -Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSWangDianCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForWangDianViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JSBranchesModelRows * model = _dataArr[indexPath.row];
    cell.labelOne.text = [NSString stringWithFormat:@"店名:%@",model.GroupName];
    cell.labelTwo.text = [NSString stringWithFormat:@"地址:%@",model.Address];
    cell.labelfour.text = [NSString stringWithFormat:@"距离:%@",model.Distiance];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.xinpeiauto.com/factoryimg/%@.jpg",model.GroupId]] placeholderImage:[UIImage imageNamed:@"未上传"]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



/**
 *  授权状态发生改变时调用
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        //        开始定位
        [self.locManager startUpdatingLocation];
    }
}
/**
 *  获取到位置信息之后就会调用(调用频率非常高)
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    _latitude = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
    _longitude = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
    [self.mj_header beginRefreshing];
    [self dingWei:nil];
}
//三方工具
#pragma mark
#pragma mark -Third-Party
@end
