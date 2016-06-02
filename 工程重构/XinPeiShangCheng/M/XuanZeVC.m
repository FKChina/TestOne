//
//  XuanZeVC.m
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "XuanZeVC.h"

static NSString * identifierForCollectionView = @"identifierForCollectionView";

#define SCROLL_VIEW_HEIGHT self.yiYouChePai.frame.size.height/6
#define SCROLL_VIEW_WIDTH self.yiYouChePai.frame.size.width/2

@interface XuanZeVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSString * _chePiaName;  //选中的车牌名字
    NSNumber * _cheKuCarId;       //选中的车型id
    UserModelOne * _model;   //车库数据模型
    NSNumber * _carId;       //选中的车型id
}


@end

@implementation XuanZeVC


#pragma mark
#pragma mark View_Life_Cycle
//界面将要出现时更新车库数据--本地数据
-(void)viewWillAppear:(BOOL)animated
{
//    刷新导航栏
    [self refrashNavigationBar];
//    判断数据是否要刷新
    if ([self isNeedRefrash]) {
        [self.yiYouChePai.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
    [self headerRereshing];
    [self.yiYouChePai.mj_header beginRefreshing];
}
#pragma mark
#pragma mark MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark UI

-(void)configUI
{
    
    _carId = @10000000;
//    已有车牌列表
    [self.yiYouChePai registerNib:[UINib nibWithNibName:@"ChePaiCell" bundle:nil] forCellWithReuseIdentifier:identifierForCollectionView];
    self.yiYouChePai.dataSource = self;
    self.yiYouChePai.delegate = self;
    
    
//    选择按钮
    [self.xuanZenBtn addTarget:self action:@selector(xuanZenBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.xuanZenBtn.layer.cornerRadius = 10;
    self.xuanZenBtn.layer.masksToBounds = YES;
    
//    添加按钮
    [self.addBtn addTarget:self action:@selector(addChePiaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.cornerRadius = 10;
    self.addBtn.layer.masksToBounds = YES;
    
//    对应车型标签
    self.duiYingCheXingLabel.layer.cornerRadius = 10;
    self.duiYingCheXingLabel.layer.masksToBounds = YES;
    self.duiYingCheXingLabel.numberOfLines = 0;
    self.duiYingCheXingLabel.adjustsFontSizeToFitWidth = YES;
}
#pragma mark
#pragma mark Data
//读取车库数据
-(void)getDataOfCheKu
{
    NSDictionary * dic1 = @{@"actionname":@"user_car_get",@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]};
    [[NET new]getDataWithDic:dic1 CompelementHandle:^(id data) {
        _model = data;
        [self.yiYouChePai reloadData];
        [self.yiYouChePai.mj_header endRefreshing];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_model == nil) {
            [self.yiYouChePai.mj_header endRefreshing];
        }
    });
}
#pragma mark
#pragma mark Action
//确定选择车牌
-(IBAction)xuanZenBtnClicked:(UIButton *)btn
{
    if (_chePiaName == nil || [_chePiaName isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请选择车牌号！"];
    }
    if (_chePiaName != nil && ![_chePiaName isEqualToString:@""]&&self.duiYingCheXingLabel.text != nil && ![self.duiYingCheXingLabel.text isEqualToString:@""]&&![self.duiYingCheXingLabel.text isEqualToString:@"未选中任何车牌"]) {
        //获取通过车型id
        [MBProgressHUD showMessage:@"匹配中……"];
        [[NET new]getDataWithDic:@{@"actionname":@"LoadTypeCarForCarTypeId",@"CarTypeId":_carId}
         
         CompelementHandle:^(id data) {
             NSString * Pid = data;
             [MBProgressHUD hideHUD];
             [self changeOrderMessage];
//             根据Pid修改车型对应套餐
             if ([Pid isEqualToString:@"15"])
             {
//                 推荐一类套餐
                 [[NSUserDefaults standardUserDefaults]setObject:@"7" forKey:USER_TAOCANTYPE];
             }else if ([Pid isEqualToString:@"40"])
             {
//                 推荐二类套餐
                 [[NSUserDefaults standardUserDefaults]setObject:@"6" forKey:USER_TAOCANTYPE];
             }else if ([Pid isEqualToString:@"60"])
             {
//                 推荐三类套餐
                 [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:USER_TAOCANTYPE];
             }
             if ([self.tiaoZhuanZhuangTai isEqualToString:@"0"]) {
                 [self.navigationController popViewControllerAnimated:YES];
             }else if ([self.tiaoZhuanZhuangTai isEqualToString:@"1"])
             {
                 [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"] animated:YES];
             }
             
         }];
    }
}

//切换到添加车牌界面
-(IBAction)addChePiaBtnClicked:(UIButton *)btn
{
    self.duiYingCheXingLabel.text = @"未选中任何车牌";
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TianJiaVC"] animated:YES];
}


/**
 *下拉刷新
 */
- (void)headerRereshing
{
    MJRefreshNormalHeader * header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataOfCheKu)];
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
    self.yiYouChePai.mj_header = header;
}
#pragma mark
#pragma mark Function





-(void)changeOrderMessage
{
//    修改订单车牌
    [[NSUserDefaults standardUserDefaults]setObject:_chePiaName forKey:USER_CHEPAI];
//    修改订单车型
    [[NSUserDefaults standardUserDefaults]setObject:self.duiYingCheXingLabel.text forKey:USER_CHEXING];
//    修改cartypeid
    [[NSUserDefaults standardUserDefaults]setObject:_cheKuCarId forKey:USER_CHEXINGID];
//    修改套餐信息
//    ………………………………
//    修改是否需要刷新状态
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:USER_ISREFRASH];
}




#pragma mark
#pragma mark Delegate

// 设置元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _model.rows.count;
}
// 返回每个元素
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChePaiCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierForCollectionView forIndexPath:indexPath];
    UserCarModel * model = _model.rows[indexPath.row];
    cell.chePaiLabel.text = model.CarNum;
    [cell.image setImage:[UIImage imageNamed:@"chose1"]];
    
    
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 选中某一个单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserCarModel * model = _model.rows[indexPath.row];
    ChePaiCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    _chePiaName =  model.CarNum;
    _cheKuCarId = model.Id;
    _carId = model.CarType;
    self.duiYingCheXingLabel.text = model.CarName;
    
    
    
    [cell.image setImage:[UIImage imageNamed:@"chose2"]];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChePaiCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell.image setImage:[UIImage imageNamed:@"chose1"]];
}
// 返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCROLL_VIEW_WIDTH-10, 30);
}
// 返回每个section与上左下右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
@end
