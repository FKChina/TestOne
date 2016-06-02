//
//  JSYuYueXiangQingVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/25.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSYuYueXiangQingVC.h"


#define JSSafeString(str) (str == nil ? @"" : str)
#define LIMIT_COUNT 10


static NSString * identifierForYuYueXiangQingCell = @"identifierForWangDianCell";
@interface JSYuYueXiangQingVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UITextFieldDelegate,JSDiTuVCDelegate>
{
    MJRefreshAutoNormalFooter * _footer;
}

@property (weak, nonatomic) IBOutlet UILabel * loactionLabel;//定位
@property (weak, nonatomic) IBOutlet UILabel * taoCanLanel;//套餐名字标签
@property (weak, nonatomic) IBOutlet UITextField * showTextField;//时间选择器
@property (weak, nonatomic) IBOutlet UITableView *wangDianTable;//网点列表
@property (weak, nonatomic) IBOutlet UIButton *dingWeiBtn;//定位按钮
@property (weak, nonatomic) IBOutlet UIButton *dingGouBtn;//订购按钮

@property (weak, nonatomic) IBOutlet UIView *backGroundView;


//时间选择器
@property (strong, nonatomic) UIDatePicker *showDatePicker;
//帮助栏
@property (strong, nonatomic) UIToolbar * showToolBar;
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
//当前选中的修理厂
@property (assign, nonatomic) NSInteger xuanZhongWeiZhi;

@property (assign, nonatomic) NSString * groupid;//修理厂ID
@property (assign, nonatomic) NSString * groupName;//修理厂名称
@property (assign, nonatomic) NSString * fac_replare;//修理厂地址
@property (assign, nonatomic) NSString * yytime;//预约时间



@property(copy ,nonatomic) NSDate * dangQianDate;//当前时间
@property(copy ,nonatomic) NSDate * xuanZeDate;;//选中时间
@end

@implementation JSYuYueXiangQingVC

//初始化定位管理者
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

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle

-(void)viewWillAppear:(BOOL)animated
{
    [self refrashNavigationBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    加载界面
    [self configUI];
    //    添加下拉刷新
    [self headerRereshing];
//    添加上拉加载
    [self footerRereshing];
    
    //判断是否可以定位
    if ([self locationCurrent])
    {
        //        开始定位
        [self.locManager startUpdatingLocation];
        [_footer setTitle:@"请允许定位！" forState:MJRefreshStateNoMoreData];
    }else
    {
        //        提示设置权限
        _dataArr = @[];
        [_footer setTitle:@"请允许定位！" forState:MJRefreshStateNoMoreData];
        [MBProgressHUD showError:@"请设置定位权限！"];
    }
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
    
    _dangQianDate = [NSDate date];
    _xuanZeDate = [NSDate alloc];
//    设置套餐属性的值
    _taoCanLanel.text = self.taoCanName;
//    初始选中的修理厂位置
    _xuanZhongWeiZhi = 1000;
    
    
    //    设置网点列表各项属性
    _wangDianTable.delegate = self;
    _wangDianTable.dataSource = self;
    _wangDianTable.layer.cornerRadius = 5;
    _wangDianTable.layer.masksToBounds = YES;
    [self.wangDianTable registerNib:[UINib nibWithNibName:@"JSYuYueXiangQingTableViewCell" bundle:nil] forCellReuseIdentifier:identifierForYuYueXiangQingCell];
    self.wangDianTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //    设置当前位置标签属性
    _loactionLabel.adjustsFontSizeToFitWidth = YES;
    
    //    设置时间文本框的代理
    _showTextField.delegate = self;
    //    初始化时间选择器
    _showDatePicker = [UIDatePicker new];
    //    嵌入时间选择器
    _showTextField.inputView = _showDatePicker;
    //    初始化toolbar
    _showToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
    
    
    //    设置toolbar属性
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClicked:)];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * okItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okBtnClicked:)];
    
    //    添加toolbar属性
    _showToolBar.items = @[cancelItem,spaceItem, okItem];
    //    嵌入toolbar
    _showTextField.inputAccessoryView = _showToolBar;
    _backGroundView.layer.cornerRadius = 5;
    _backGroundView.layer.masksToBounds = YES;
    
    [_dingWeiBtn addTarget:self action:@selector(mapBntClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    //订购按钮属性
    [_dingGouBtn addTarget:self action:@selector(subscribeClicked:) forControlEvents:UIControlEventTouchUpInside];
}
//数据处理
#pragma mark
#pragma mark -Data


-(void)loadNewData
{
    //    第一次加载数据
    
    if (_latitude.length != 0 && _latitude !=nil && _longitude.length != 0 && _longitude !=nil) {
        _page = 0;
        NSDictionary * dic = @{@"actionname":@"getxlcinfobyaddress",@"limit":[NSString stringWithFormat:@"%d",LIMIT_COUNT],@"pageIndex":[NSString stringWithFormat:@"%ld",_page],@"latitude":_latitude,@"longitude":_longitude};
        //    发送网络请求
        [[NET new]getDataWithDic:dic CompelementHandle:^(id data)
         {
             _model = data;
             _dataArr = _model.rows;
             //         列表刷新
             [self.wangDianTable reloadData];
             //         添加上拉加载更多数据
             //         下拉刷新结束
             [self.wangDianTable.mj_header endRefreshing];
             //         判断数据量
             if (_model.rows.count < LIMIT_COUNT) {
                 // 变为没有更多数据的状态
                 [_footer endRefreshingWithNoMoreData];
             }
         }];
    }else
    {
        [MBProgressHUD showError:@"请进行定位之后再刷新!"];
        [self.wangDianTable.mj_header endRefreshing];
    }
}

-(void)loadMoreData
{
    
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
             [self.wangDianTable reloadData];
             //        结束上拉加载
             [self.wangDianTable.mj_footer endRefreshing];
             //        判断数据量
             if (_model.rows.count < LIMIT_COUNT) {
                 // 变为没有更多数据的状态
                 [_footer endRefreshingWithNoMoreData];
             }
         }];
    }else
    {
        [MBProgressHUD showError:@"请进行定位之后再刷新!"];
        [self.wangDianTable.mj_header endRefreshing];
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
 *使用回调代理方法
 */
- (void)sendVaules:(NSArray *)array;
{
    _latitude = array[0];
    _longitude = array[1];
    [self dingWei:nil];
    [self.wangDianTable.mj_header beginRefreshing];
}




/**
 *打开地图定位
 */
-(IBAction)mapBntClicked:(UIButton *)sender
{
    JSDiTuVC * vc = [[JSDiTuVC alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)re

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
             _loactionLabel.text = JSSafeString(@"您确定还在地球上吗?");
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
             _loactionLabel.text = address;
         }
     }];
}

/**
 *取消时间选择器
 */
-(IBAction)cancelBtnClicked:(id)sender
{
    [_showTextField resignFirstResponder];
}
/**
 *选择时间
 */
-(IBAction)okBtnClicked:(id)sender
{
    _xuanZeDate = _showDatePicker.date;
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    _showTextField.text = [formatter stringFromDate:_xuanZeDate];
    [_showTextField resignFirstResponder];
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
    self.wangDianTable.mj_header = header;
}
/**
 *上拉加载
 */
- (void)footerRereshing
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置文字
    [_footer setTitle:@"加载中……" forState:MJRefreshStateRefreshing];
    // 设置字体
    _footer.stateLabel.font = [UIFont systemFontOfSize:17];
    // 设置颜色
    _footer.stateLabel.textColor = XINPEI_COLOR;
    // 设置尾部
    self.wangDianTable.mj_footer = _footer;
}

/**
 *
 */
//-(BOOL)panDuanShiJian
//{
//    //创建一个时间戳对象
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    //设置格式
//    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
//    //获取当前系统时间
//    NSDate *date = [NSDate date];
//    //把时间对象转换成字符串对象
//    NSString *dateString = [formatter  stringFromDate:date];
//    NSLog(@"dateString = %@",dateString);
//    NSString * dangQian = [formatter stringFromDate:_dangQianDate];
//    NSString * xuanZe = [formatter stringFromDate:_xuanZeDate];
//    if ([xuanZe intValue] - [dangQian intValue] < (24* 3600000)) {
//        return NO;
//    }else
//    {
//        return YES;
//    }
//}
/**
 *预约按钮点击
 */
-(IBAction)subscribeClicked:(id)sender
{
    
    NSMutableString * timeStr = [NSMutableString stringWithString:self.showTextField.text];
    _yytime = timeStr;
    if (_yytime.length != 0 && _yytime != nil&&_groupid.length != 0 && _groupid != nil&&_groupName.length != 0 && _groupName != nil&&_fac_replare.length != 0 && _fac_replare != nil) {
        [[NET new]getDataWithDictionary:@{@"actionname":@"orderpoint",@"groupid":_groupid,@"groupName":_groupName,@"fac_replare":_fac_replare,@"yytime":_yytime,@"id":self.yuYueId,@"appointType":@"1",@"Uid":[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]} WithJSReturnDataBlock:^(id data)
         {
             if ([[data objectForKey:@"key"] isEqualToString:@"1"])
             {
                 [MBProgressHUD showSuccess:@"预约成功!"];
                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:USER_ISREFRASH];
                 [self.navigationController popToRootViewControllerAnimated:YES];
             }else
             {
                 [MBProgressHUD showError:@"请重试！"];
             }
         } WithJSErrorMessageBlock:^(id errorMessage) {
             [MBProgressHUD showError:@"请重试！"];
         } WithJSFailureMessageBlock:^(id failureMessage) {
             [MBProgressHUD showError:@"请重试！"];
         }];
    }else
    {
        [MBProgressHUD showError:@"信息不全!"];
    }
}
//代理区域
#pragma mark
#pragma mark -Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSYuYueXiangQingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForYuYueXiangQingCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JSBranchesModelRows * model = _dataArr[indexPath.row];
    cell.xiuLiChang.text =[NSString stringWithFormat:@"店名:%@",model.GroupName];
    cell.address.text = [NSString stringWithFormat:@"地址:%@",model.Address];
    cell.juLl.text = [NSString stringWithFormat:@"距离:%@",model.Distiance];
    [cell.seletedImage setImage:[UIImage imageNamed:@"chose1"]];
    if (indexPath.row == _xuanZhongWeiZhi) {
        [cell.seletedImage setImage:[UIImage imageNamed:@"chose2"]];
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _xuanZhongWeiZhi = indexPath.row;
    JSYuYueXiangQingTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.seletedImage setImage:[UIImage imageNamed:@"chose2"]];
    JSBranchesModelRows * model = _dataArr[indexPath.row];
    _groupid = [NSString stringWithFormat:@"%@",model.GroupId];
    _groupName = model.GroupName;
    _fac_replare = model.Address;
    [self.wangDianTable reloadData];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSYuYueXiangQingTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.seletedImage setImage:[UIImage imageNamed:@"chose1"]];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    _latitude = [NSString stringWithFormat:@"%lf",location.coordinate.latitude];
    _longitude = [NSString stringWithFormat:@"%lf",location.coordinate.longitude];
    [self.wangDianTable.mj_header beginRefreshing];
    [self dingWei:nil];
}

//三方工具
#pragma mark
#pragma mark -Third-Party


@end
