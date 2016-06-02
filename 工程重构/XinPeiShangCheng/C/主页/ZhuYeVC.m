//
//  ZhuYeVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/2.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "ZhuYeVC.h"
#import "JSXPWangDianTableView.h"
#import "JSCycleView.h"

#define ZHUCEBTN_TAG 1001
static NSString * identifierForWangDianCell = @"identifierForWangDianCell";
static NSString * headerIdentifier = @"myCollectionHeaderAndFooter";


@interface ZhuYeVC ()
{
    NSArray * _guangGaoArr;//广告数据
    NSArray * _dataArr;
    ADLBView * _addView;
}   





@property (strong , nonatomic) JSXPWangDianTableView * wangDianTableView;


@property (strong,nonatomic) JSCollectionHeaderReusableView *headerView;


@end
@implementation ZhuYeVC

#pragma mark
#pragma mark View_Life_Cycle

- (void)viewWillAppear:(BOOL)animated
{
    [self refrashNavigationBar];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self configUI];
    
}
#pragma mark
#pragma mark MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark UI

-(void)configUI
{
    self.wangDianTableView = [[JSXPWangDianTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WNavigation(1))];
    
    [self.view addSubview:self.wangDianTableView];
    
    
    [self loadHeaderViewData];
}

#pragma mark
#pragma mark Data

-(void)loadHeaderViewData
{
    NSDictionary * guangGaoDic = @{@"actionname":@"loadtitlepic"};
    _headerView = [[[NSBundle mainBundle]loadNibNamed:@"JSCollectionHeaderReusableView" owner:nil options:nil] lastObject];
    
    for (int i =0; i < _headerView.btnArr.count ; i ++) {
        UIButton * btn = _headerView.btnArr[i];
        [btn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = ZHUCEBTN_TAG + i;
    }
    
    [[NET new]getPictureWithDic:guangGaoDic CompelementHandle:^(id data) {
        _guangGaoArr = data;
        //获取广告栏中标题的值
        NSMutableArray * titleArr = [NSMutableArray new];
        for (JSNeiRongModel * model in _guangGaoArr) {
            [titleArr addObject:model.title];
        }
        NSMutableArray * arr = [NSMutableArray new];
        for (int i = 0; i < _guangGaoArr.count; i ++)
        {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headerView.ADView.bounds.size.width, _headerView.ADView.bounds.size.height)];
            JSNeiRongModel * model = _guangGaoArr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.picurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 [arr addObject:imageView.image];
                 if (i == _guangGaoArr.count-1)
                 {
                     if (arr.count < 3) {
                         for (int i = (int)arr.count; i < 3; i ++) {
                             UIImage * image = [UIImage imageNamed:@"未上传"];
                             [arr addObject:image];
                         }
                     }
                     ADLBView * addView = [[ADLBView alloc]initWithFrame:CGRectMake(0, 0, _headerView.ADView.bounds.size.width, _headerView.ADView.bounds.size.height) withImages:arr withTitle:titleArr withCallBack:^(NSInteger chooseIndex)
                                           {
                                           }];
                     [_headerView.ADView addSubview:addView];
                     self.wangDianTableView.tableHeaderView = _headerView;
                     [self.wangDianTableView reloadData];
                     [self.wangDianTableView.mj_header endRefreshing];
                 }
             }];
        }
    }];
    
//    CGFloat ADViewHeight = 120;
//    CGFloat tuiJianViewHeight = 70;
//    CGFloat taoCanViewHeight = 80;
//    CGFloat wangDianViewHeight = 40;
//    CGFloat headerViewHeight = ADViewHeight + tuiJianViewHeight + taoCanViewHeight + wangDianViewHeight;
//    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewHeight)];
//    NSDictionary * canShuDic = @{@"actionname":@"loadtitlepic"};
//    [[NET new]getPictureWithDic:canShuDic CompelementHandle:^(id data) {
//        _guangGaoArr = data;
//        //获取广告栏中标题的值
//        NSMutableArray * titleArr = [NSMutableArray new];
//        for (JSNeiRongModel * model in _guangGaoArr) {
//            [titleArr addObject:model.title];
//        }
//        NSMutableArray * arr = [NSMutableArray new];
//        for (int i = 0; i < _guangGaoArr.count; i ++)
//        {
//            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headerView.ADView.bounds.size.width, _headerView.ADView.bounds.size.height)];
//            JSNeiRongModel * model = _guangGaoArr[i];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:model.picurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//             {
//                 [arr addObject:imageView.image];
//                 if (i == _guangGaoArr.count-1)
//                 {
//                     if (arr.count < 3) {
//                         
//                         
//                         
//                         ADLBView * addView = [[ADLBView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADViewHeight) withImages:arr withTitle:titleArr withCallBack:^(NSInteger chooseIndex)
//                                               {
//                                               }];
//                         [_headerView.ADView addSubview:addView];
//                     }else
//                     {
//                         ADLBView * addView = [[ADLBView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ADViewHeight) withImages:arr withTitle:titleArr withCallBack:^(NSInteger chooseIndex)
//                                               {
//                                               }];
//                         [headerView addSubview:addView];
//                     }
//                     self.wangDianTableView.tableHeaderView = headerView;
//                     [self.wangDianTableView reloadData];
//                     [self.wangDianTableView.mj_header endRefreshing];
//                 }
//             }];
//        }
//    }];
//    
//    
//    
//    JSCycleView * tuiJianView = [[JSCycleView alloc]initWithFrame:CGRectMake(0, ADViewHeight, SCREEN_WIDTH, tuiJianViewHeight)];
//    NSArray * imageArr1 = @[@"button_yangche",@"button_yuyue",@"button_wangdian",@"button_jifen",@"button_fenxiang"];
//    [tuiJianView creatControllersWithCycleType:TypeButton withTitleArr:@[] withImageNameArr:imageArr1 withButtonArr:@[] withCross:1];
//    
//    [headerView addSubview:tuiJianView];
//    
//    
//    
//    JSCycleView * taoCanView = [[JSCycleView alloc]initWithFrame:CGRectMake(0, ADViewHeight + tuiJianViewHeight, SCREEN_WIDTH, taoCanViewHeight)];
//    NSArray * imageArr2 = @[@"button_tuijian",@"button_zhiXiang",@"button_zhiXin",@"button_zhiShang"];
//    [tuiJianView creatControllersWithCycleType:TypeButton withTitleArr:@[] withImageNameArr:imageArr2 withButtonArr:@[] withCross:1];
//    [headerView addSubview:taoCanView];
//    
//    
//    
//    JSCycleView * wangDianView = [[JSCycleView alloc]initWithFrame:CGRectMake(0, ADViewHeight + tuiJianViewHeight + taoCanViewHeight, SCREEN_WIDTH, wangDianViewHeight)];
//    NSArray * imageArr3 = @[@"button_zixuan"];
//    [tuiJianView creatControllersWithCycleType:TypeButton withTitleArr:@[] withImageNameArr:imageArr3 withButtonArr:@[] withCross:1];
//    [headerView addSubview:wangDianView];
//
    
    
    
    

}
#pragma mark
#pragma mark Action

/**
 *所有的按钮跳转
 */
-(IBAction)allBtnClicked:(UIButton *)btn
{
    
    if (btn.tag == ZHUCEBTN_TAG ) {
        ChaoZhiTableViewController * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChaoZhiTableViewController"];
        [self.navigationController pushViewController:XQVC animated:YES];
        
    }else if (btn.tag == ZHUCEBTN_TAG +1)
    {
        JSYuYueVC * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JSYuYueVC"];
        [self.navigationController pushViewController:XQVC animated:YES];
    }else if (btn.tag == ZHUCEBTN_TAG +2 || btn.tag == ZHUCEBTN_TAG  +9)
    {
        WangDianVC * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WangDianVC"];
        [self.navigationController pushViewController:XQVC animated:YES];
        
        
    }else if (btn.tag == 1004)
    {
        [self.navigationController pushViewController:[[JSIntegralViewController alloc]init] animated:YES];
    }else if (btn.tag == 1005)
    {
        
    }else if (btn.tag == 1006)
    {
        JSXiangQingVC * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JSXiangQingVC"];
        [self.navigationController pushViewController:XQVC animated:YES];
        XQVC.xiangQingType = @"0";
    }else if (btn.tag == 1007||btn.tag == 1008||btn.tag == 1009)
    {
        JSXiangQingVC * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JSXiangQingVC"];
        [self.navigationController pushViewController:XQVC animated:YES];
        XQVC.xiangQingType = [NSString stringWithFormat:@"%ld",btn.tag-1007];
    }
}

-(IBAction)wangDianBtnClicked:(id)sender{
    WangDianVC * XQVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WangDianVC"];
    [self.navigationController pushViewController:XQVC animated:YES];
}
#pragma mark
#pragma mark Function


#pragma mark
#pragma mark Delegate

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    JSZhuYeSectionFootView * view = [[[NSBundle mainBundle]loadNibNamed:@"JSZhuYeSectionFootView" owner:nil options:nil] lastObject];
    [view.wangDianBtn addTarget:self action:@selector(wangDianBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return  view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_dataArr.count != 0) {
        return 40;
    }else
    {
        return 0;
    }
}


@end
