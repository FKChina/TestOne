//
//  TianJiaVC.m
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "TianJiaVC.h"

//定义cell标识

static NSString * identifierForCheXiTableView = @"identifierForCheXiTableView";
static NSString * identifierForCheXingTableView = @"identifierForCheXingTableView";
static NSString * identifierForZiMuTableView = @"identifierForZiMuTableView";


@interface TianJiaVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

{
    NSInteger _dangQianZiMi;      //选中首字母在首字母数据源的位置
    NSInteger _dangQianCheXi;     //选中车系在车系数组中的位置
    NSInteger _dangQianPaiLiang;  //选中的车型的排量在排量数组中的位置
    NSInteger _dangQianCheXing;   //选中车型在车型数组中的位置
    
    
    NSMutableArray * _ziMuArr;    //首字母数据源
    
    
    NSMutableArray * _cheXiArr;   //车型数据源
    NSArray * _cheXiSectionArr;   //当前字母对应的车型数据源
    
    
    NSInteger _isDataCompelete;   //加载数据的次数
}


@end

@implementation TianJiaVC


//视图周期
#pragma mark
#pragma mark -View_Life_Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
    [self headerRereshing];
    [self.cheXiTableView.mj_header beginRefreshing];
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
//    初始化车数据源
    _cheXiArr = [NSMutableArray new];
    

    
//    车牌输入框代理
    self.shuRuChePaiText.delegate = self;
    
//    覆盖视图的透明度
    self.cheXingFuGaiView.alpha = 0;
    self.paiLiangFuGaiView.alpha = 0;
    
//    选择车型框的数据样式
    self.yiXuanCheXingLabel.adjustsFontSizeToFitWidth = YES;
    self.yiXuanCheXingLabel.numberOfLines = 0;
    
//    确认按钮
    [self.queRenBtn addTarget:self action:@selector(queRenBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.queRenBtn.layer.cornerRadius = 20;
    self.queRenBtn.layer.masksToBounds = YES;
    
//    清空按钮
    [self.cleanBtn addTarget:self action:@selector(cleanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.cleanBtn.layer.cornerRadius = 20;
    self.cleanBtn.layer.masksToBounds = YES;
    
//    车系列表
    self.cheXiTableView.delegate = self;
    self.cheXiTableView.dataSource = self;
    self.cheXiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.cheXiTableView registerNib:[UINib nibWithNibName:@"TianJiaCell" bundle:nil]forCellReuseIdentifier:identifierForCheXiTableView];
    
//    车型列表
    self.cheXingTableView.delegate = self;
    self.cheXingTableView.dataSource = self;
    self.cheXingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.cheXingTableView registerNib:[UINib nibWithNibName:@"TianJiaCellCheXingCell" bundle:nil]forCellReuseIdentifier:identifierForCheXingTableView];
    
//    排量列表
    self.paiLiangTableView.delegate = self;
    self.paiLiangTableView.dataSource = self;
    self.paiLiangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.paiLiangTableView registerNib:[UINib nibWithNibName:@"TianJiaCellCheXingCell" bundle:nil]forCellReuseIdentifier:identifierForCheXingTableView];
    
//    字母列表
    self.ziMuTableView.delegate = self;
    self.ziMuTableView.dataSource = self;
    self.ziMuTableView.scrollEnabled = NO;
    self.ziMuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.ziMuTableView registerNib:[UINib nibWithNibName:@"JSTianJiaZiMuTableViewCell" bundle:nil]forCellReuseIdentifier:identifierForZiMuTableView];

}
//数据处理
#pragma mark
#pragma mark -Data

//加载处理车库数据
-(void)loadData
{
    
    //    加载完成全部数据
    _isDataCompelete = 0;
//    全部字母数组
    NSArray * arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    NSMutableDictionary * dic = [NSMutableDictionary new];
//    定义临时字母数组
    NSMutableArray * arrZiMu = [NSMutableArray new];
//    循环获取数据
    for (int i = 0; i < arr.count ; i ++) {
        NSDictionary * dictionary = @{@"actionname":@"carseries_get_all",@"FirstL":arr[i]};
        [[NET new]getDataWithDic:dictionary CompelementHandle:^(id data)
         {
             NSArray * dataArr = data;
             if (dataArr.count != 0)
             {//数据不为空的时候
                 //将字母与数据对应添加到字典
                 [dic setObject:dataArr forKey:arr[i]];
                 //因异步获取数据，将字母数据乱序加载到临时数组
                 [arrZiMu addObject:arr[i]];
             }
             if (_isDataCompelete == arr.count - 1)
             {//当数据全部获取之后
                 //排序字母数组
                 _ziMuArr = [NSMutableArray arrayWithArray:[arrZiMu sortedArrayUsingSelector:@selector(compare:)]];
                 //根据正序字母数组来获取对应的车源数据
                 for (NSString * key in _ziMuArr)
                 {
                     //添加到车源数据
                     [_cheXiArr addObject:[dic objectForKey:key]];
                 }
                 [self.ziMuTableView reloadData];
                 [self.cheXiTableView reloadData];
                 [self.cheXiTableView.mj_header endRefreshing];
            }
             _isDataCompelete++;
         }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //延迟函数内部
        if (_cheXiArr.count == 0)
        {
            [self.cheXiTableView.mj_header endRefreshing];
        }
    });
}
//逻辑功能
#pragma mark
#pragma mark -Function

-(void)tap:(UITapGestureRecognizer *)recognizer
{
    //    移出车型覆盖视图
    [self cheXingfuGaiShiTuWeiZhiFuYuan];
}
-(void)tapOne:(UITapGestureRecognizer *)recognizer
{
    //    移出排量覆盖视图
    [self paiLiangfuGaiShiTuWeiZhiFuYuan];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.shuRuChePaiText resignFirstResponder];
}
/**
 *确认添加按钮
 */
-(IBAction)queRenBtnClicked:(UIButton *)btn
{
    //    放弃编辑
    [self.shuRuChePaiText resignFirstResponder];
    //    移出覆盖视图
    [self cheXingfuGaiShiTuWeiZhiFuYuan];
    [self paiLiangfuGaiShiTuWeiZhiFuYuan];
    
    if (self.shuRuChePaiText.text == nil || [self.shuRuChePaiText.text isEqualToString:@""])
    {//判断车牌输入框内容是否合法
        [MBProgressHUD showError:@"请输入车牌号！"];
    }
    else if (self.yiXuanCheXingLabel.text == nil || [self.yiXuanCheXingLabel.text isEqualToString:@""]||[self.yiXuanCheXingLabel.text isEqualToString:@"请选择车型"])
    {//判断车型标签内容是否合法
        [MBProgressHUD showError:@"选择车型！"];
    }
    if (self.shuRuChePaiText.text != nil && ![self.shuRuChePaiText.text isEqualToString:@""]&&self.yiXuanCheXingLabel.text != nil && ![self.yiXuanCheXingLabel.text isEqualToString:@""]&&![self.yiXuanCheXingLabel.text isEqualToString:@"请选择车型"])
    {//数据全部合法
        
        //        获取功能数据（新增车牌）
        
        CheXiModel * model = _cheXiSectionArr[_dangQianCheXi];
        CheXingModel * model1 = ((NSArray *)model.children)[_dangQianCheXing];
        NSMutableDictionary * netDic = [NSMutableDictionary new];
        if (model1.children.count != 0)
        {//当前数据有对应的下一层数据
            PaiLiangModel * model2 =((NSArray *)model1.children)[_dangQianPaiLiang];
            NSMutableString * str = [NSMutableString stringWithString:self.shuRuChePaiText.text];
            [netDic setObject:str forKey:@"CarNum"];
            [netDic setObject:@"add_user_car" forKey:@"actionname"];
            [netDic setObject:model2.CarTypeId forKey:@"CarType"];
            [netDic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:USER_UID] forKey:@"Uid"];
            [netDic setObject:model.TypeName forKey:@"CarName"];
        }else
        {//当前数据没有对应的下一层数据
            NSMutableString * str = [NSMutableString stringWithString:self.shuRuChePaiText.text];
            [netDic setObject:str forKey:@"CarNum"];
            [netDic setObject:@"add_user_car" forKey:@"actionname"];
            [netDic setObject:model1.CarTypeId forKey:@"CarType"];
            [netDic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:USER_UID] forKey:@"Uid"];
            [netDic setObject:model.TypeName forKey:@"CarName"];
        }
        //        上传数据
        [MBProgressHUD showMessage:@"正在添加……"];
        /**修改**/
        [[NET new]getDataWithDic:netDic CompelementHandle:^(id data) {
            NSDictionary * dic = data;
            if ([[dic objectForKey:@"retMsg"] isEqualToString:@"新增车牌成功！"])
            {//上传成功
                [MBProgressHUD hideHUD];
                //变更跳转状态
                [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:USER_TIAOZHUANSKIP];
                
                [MBProgressHUD showSuccess:@"添加成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else if([[dic objectForKey:@"retMsg"] isEqualToString:@"车牌已存在！"])
            {//车牌已经存在
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"车牌已存在！"];
            }
            else
            {//添加失败
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"添加失败！"];
            }
        }];
    }
}

//覆盖视图移出
-(void)cheXingfuGaiShiTuWeiZhiFuYuan
{
    if (self.cheXingTableView.bounds.size.width > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.cheXingTableView .frame =CGRectMake(SCREEN_WIDTH, 0, 0, self.paiLiangView.bounds.size.height);
            self.cheXingFuGaiView.alpha = 0;
        }];
        self.cheXingFuGaiView.userInteractionEnabled = NO;
        self.cheXingView.userInteractionEnabled = NO;
    }
}
-(void)paiLiangfuGaiShiTuWeiZhiFuYuan
{
    if (self.paiLiangTableView.bounds.size.width > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.paiLiangTableView .frame =CGRectMake(SCREEN_WIDTH, 0, 0, self.paiLiangView.bounds.size.height);
            self.paiLiangFuGaiView.alpha = 0;
        }];
        self.paiLiangFuGaiView.userInteractionEnabled = NO;
        self.paiLiangView.userInteractionEnabled = NO;
    }
}
//清除已输入车库车牌信息
-(IBAction)cleanBtnClicked:(UIButton *)btn
{
    self.shuRuChePaiText.text = @"";
    self.yiXuanCheXingLabel.text = @"请选择车型";
}

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
    self.cheXiTableView.mj_header = header;
}


//代理区域
#pragma mark
#pragma mark -Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.cheXiTableView)
    {
        return _ziMuArr.count;
    }else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.cheXiTableView)
    {
        return ((NSArray *)_cheXiArr[section]).count;
    }else if (tableView == self.cheXingTableView)
    {
        return ((CheXiModel *)(_cheXiSectionArr[_dangQianCheXi])).children.count;
    }else if (tableView == self.ziMuTableView)
    {
        return _ziMuArr.count;
    }else
    {
        return ((CheXingModel *)((CheXiModel *)_cheXiSectionArr[_dangQianCheXi]).children[_dangQianCheXing]).children.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.ziMuTableView)
    {
        return self.ziMuTableView.frame.size.height/_ziMuArr.count;
    }else
    {
        return 40;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.ziMuTableView)
    {
        JSTianJiaZiMuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForZiMuTableView];
        cell.ziMuLabel.text = _ziMuArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (tableView == self.cheXiTableView)
    {
        TianJiaCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForCheXiTableView];
        
        if (self.shuRuChePaiText.text == nil || [self.shuRuChePaiText.text isEqualToString:@""]) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else
        {
            
        }
        NSArray * arr = _cheXiArr[indexPath.section];
        CheXiModel * model = arr[indexPath.row];
        cell.cheXiLabel.text = model.TypeName;
        return cell;
    }
    else if (tableView == self.cheXingTableView)
    {
        TianJiaCellCheXingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForCheXingTableView];
        CheXiModel * model = _cheXiSectionArr[_dangQianCheXi];
        CheXingModel * model1 = ((NSArray *)model.children)[indexPath.row];
        cell.cheXiLabel.text = model1.TypeName;
        return cell;
    }else
    {
        TianJiaCellCheXingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForCheXingTableView];
        CheXiModel * model = _cheXiSectionArr[_dangQianCheXi];
        CheXingModel * model1 = ((NSArray *)model.children)[_dangQianCheXing];
        PaiLiangModel * model2 =((NSArray *)model1.children)[indexPath.row];
        cell.cheXiLabel.text = model2.TypeName;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.ziMuTableView)
    {
        NSIndexPath * indexPathOne =  [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.cheXiTableView scrollToRowAtIndexPath:indexPathOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
    }else if (tableView == self.cheXiTableView)
    {
        if (self.shuRuChePaiText.text == nil || [self.shuRuChePaiText.text isEqualToString:@""])
        {
            [MBProgressHUD showError:@"请输入车牌！"];
        }else
        {
            _dangQianCheXi = indexPath.row;
            _cheXiSectionArr = _cheXiArr[indexPath.section];
            CheXiModel * model = _cheXiSectionArr[indexPath.row];
            if (model.children.count == 0) {
                self.yiXuanCheXingLabel.text = [NSString stringWithFormat:@"%@",model.TypeName];
                [self cheXingfuGaiShiTuWeiZhiFuYuan];
                [self paiLiangfuGaiShiTuWeiZhiFuYuan];
            }else
            {
                [self.cheXingTableView reloadData];
                [UIView animateWithDuration:0.2 animations:^{
                    self.cheXingTableView .frame =CGRectMake(FUGAI_VIEW_WIDTH, 0, SCREEN_WIDTH - FUGAI_VIEW_WIDTH, self.paiLiangView.bounds.size.height);
                    self.cheXingFuGaiView.alpha = 0.5;
                }];
                UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                self.cheXingFuGaiView.userInteractionEnabled = YES;
                [self.cheXingFuGaiView addGestureRecognizer:tapRecognizer];
                self.cheXingView.userInteractionEnabled = YES;
            }
            
        }
    }else if(tableView == self.cheXingTableView)
    {
        _dangQianCheXing = indexPath.row;
        CheXiModel * model = _cheXiSectionArr[_dangQianCheXi];
        CheXingModel * model1 = ((NSArray *)model.children)[_dangQianCheXing];
        if (model1.children.count == 0)
        {
            self.yiXuanCheXingLabel.text = [NSString stringWithFormat:@"%@\n%@",model.TypeName,model1.TypeName];
            [self cheXingfuGaiShiTuWeiZhiFuYuan];
            [self paiLiangfuGaiShiTuWeiZhiFuYuan];
        }else
        {
            self.yiXuanCheXingLabel.text = [NSString stringWithFormat:@"%@\n%@",model.TypeName,model1.TypeName];
            [self.paiLiangTableView reloadData];
            [UIView animateWithDuration:0.2 animations:^{
                self.paiLiangTableView .frame =CGRectMake(FUGAI_VIEW_WIDTH * 2, 0, SCREEN_WIDTH - FUGAI_VIEW_WIDTH * 2, self.paiLiangView.bounds.size.height);
                self.paiLiangFuGaiView.alpha = 0.5;
            }];
            UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOne:)];
            self.paiLiangFuGaiView.userInteractionEnabled = YES;
            [self.paiLiangFuGaiView addGestureRecognizer:tapRecognizer];
            self.paiLiangView.userInteractionEnabled = YES;
        }
    }else
    {
        CheXiModel * model = _cheXiSectionArr[_dangQianCheXi];
        CheXingModel * model1 = ((NSArray *)model.children)[_dangQianCheXing];
        PaiLiangModel * model2 =((NSArray *)model1.children)[indexPath.row];
        _dangQianPaiLiang = indexPath.row;
        self.yiXuanCheXingLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",model.TypeName,model1.TypeName,model2.TypeName];
        [self cheXingfuGaiShiTuWeiZhiFuYuan];
        [self paiLiangfuGaiShiTuWeiZhiFuYuan];
    }
}



- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.cheXiTableView) {
        return _ziMuArr[section];
    }else
    {
        return nil;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        [self cheXingfuGaiShiTuWeiZhiFuYuan];
        [self paiLiangfuGaiShiTuWeiZhiFuYuan];
    }];
    return YES;
}

//三方工具
#pragma mark
#pragma mark -Third-Party


@end
