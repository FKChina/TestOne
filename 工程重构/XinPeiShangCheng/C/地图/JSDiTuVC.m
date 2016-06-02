//
//  JSDiTuVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/25.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSDiTuVC.h"


#define JSSafeString(str) (str == nil ? @"" : str)



@interface JSDiTuVC ()<CLLocationManagerDelegate,MKMapViewDelegate>


@property(nonatomic,retain) CLLocationManager* locationmanager;
@property(nonatomic,retain) CLGeocoder* geocoder;



@property (strong , nonatomic)  MKMapView * mapView;
@property (strong , nonatomic)  JSBaseLabel * weiZhiLabel;

//纬度
@property (copy, nonatomic) NSString * latitude;
//经度
@property (copy, nonatomic) NSString * longitude;

@end

@implementation JSDiTuVC


//初始化定位管理者
- (CLLocationManager *)locManager
{
    if (!_locationmanager) {
        _locationmanager = [[CLLocationManager alloc] init];
        self.locationmanager.distanceFilter = 10;
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.delegate = self;
    }
    return _locationmanager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
-(void)configUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat width = self.view.bounds.size.width/5;
    CGFloat height = (self.view.bounds.size.height - 64)/10;
    
    
    
//    设置地图的属性
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, height*9)];
    //地图的代理方法
    _mapView.delegate = self;
    //是否显示当前的位置
    _mapView.showsUserLocation = YES;
    //地图的类型， iOS开发中自带的地图
    //使用第三方的地图可以查找周边环境的餐馆，学校之类的
    _mapView.mapType = MKMapTypeStandard;
    //是否允许缩放，一般都会让缩放的
    _mapView.zoomEnabled = YES;
    _mapView.scrollEnabled = YES;
    [self.view addSubview:_mapView];
    _locationmanager = [[CLLocationManager alloc]init];
    

//    设置定位的属性
    //设置定位的精度
    [_locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    //实现协议
    _locationmanager.delegate = self;
    //开始定位
    [_locationmanager startUpdatingLocation];
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    
    
    [_mapView addGestureRecognizer:mTap];
    
    
    
//    设置提示标签的属性
    JSBaseLabel * label = [[JSBaseLabel alloc]initWithFrame:CGRectMake(0, height * 9, width* 4, height*0.5)];
    [label setLabelTitle:@"点击屏幕进行定位" TitleColor:[UIColor cyanColor] BackGroundColor:[UIColor lightGrayColor] font:12 cornerRadius:height/2 boardSize:1 boardColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:label];
    
//    设置定位标签的属性
    _weiZhiLabel = [[JSBaseLabel alloc]initWithFrame:CGRectMake(0,height * 9.5,width* 4, height * 0.5)];
    [_weiZhiLabel setLabelTitle:@"" TitleColor:[UIColor cyanColor] BackGroundColor:[UIColor lightGrayColor] font:12 cornerRadius:height/2 boardSize:1 boardColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    self.weiZhiLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_weiZhiLabel];
    
    
    
//    设置定位按钮的属性
    WHButton* dingWeiBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    dingWeiBtn.frame = CGRectMake(width* 4,  height * 9, width, height);
    [dingWeiBtn setButtonTitle:@"点击定位" TitleColor:[UIColor cyanColor] BackGroundColor:[UIColor whiteColor] font:12 cornerRadius:0];
    [dingWeiBtn addTarget:self action:@selector(qieHuanWeizHI:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dingWeiBtn];
    
}

//内存告警
#pragma mark
#pragma mark -MemoryWarning

//用户界面
#pragma mark
#pragma mark -UI

//数据处理
#pragma mark
#pragma mark -Data

//逻辑功能
#pragma mark
#pragma mark -Function
/**
 *点击切换位置
 */
-(IBAction)qieHuanWeizHI:(UIButton *)sender
{
    // (4)回调协议方法
    if (_latitude.length != 0 && _latitude != nil&&_longitude.length != 0 && _longitude != nil) {
        if ([self.delegate respondsToSelector:@selector(sendVaules:)])
        {
            [self.delegate sendVaules:@[_latitude,_longitude]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [MBProgressHUD showError:@"位置不能为空!"];
    }
}


- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];//这里touchMapCoordinate就是该点的经纬度了
    _latitude = [NSString stringWithFormat:@"%f",touchMapCoordinate.latitude];
    _longitude = [NSString stringWithFormat:@"%f",touchMapCoordinate.longitude];
    [self dingWei:touchMapCoordinate];
}

/**
 *反编码获取当前地理位置，并显示
 */
-(IBAction)dingWei:(CLLocationCoordinate2D)touchMapCoordinate
{
    
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude  longitude:touchMapCoordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             //            反编码失败
             _weiZhiLabel.text = JSSafeString(@"您确定还在地球上吗?");
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
             _weiZhiLabel.text = address;
         }
     }];
}


//代理区域
#pragma mark
#pragma mark -Delegate

 -(void)locationManager:(CLLocationManager *)manager
 didUpdateLocations:(NSArray *)locations
 {
     [self.locManager stopUpdatingLocation];
     CLLocation *location = [locations lastObject];
     CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
     //显示范围，数值越大，范围就越大
     MKCoordinateSpan span = {0.05,0.05};
     MKCoordinateRegion region = {location2,span};
     [_mapView setRegion:region];
 }
//三方工具
#pragma mark
#pragma mark -Third-Party
@end
