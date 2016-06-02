//
//  ViewController.m
//  ChaoZhi_JS_29
//
//  Created by 醉卧沙场君莫笑 on 16/3/29.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "ViewController.h"



static NSString * identifierForTaoCanCell = @"identifierForTaoCanCell";

@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _taoCanJiaGe;//当前的价格位置
    NSArray * _taoCanArr;//套餐名称
    NSArray * _taoCanPriceArr;//套餐内容
    NSArray * _priceArr;//套餐价格
    UserModelOne * _model;
    BOOL _isAppear;
    NSString * _taoCanType;//自定义套餐
}
@end

@implementation ViewController





//视图周期
#pragma mark
#pragma mark -View_Life_Cycle

/**
 *视图将要出现
 */
-(void)viewWillAppear:(BOOL)animated
{
//    if ([self isNeedRefrash]) {
//        [self freshData];
//    }
}

- (void)viewDidLoad
{
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
/**
 *加载用户界面
 */
-(void)configUI
{
    CGFloat height = SCREEN_HEIGHT_WNavigation(15);
    
    CGFloat spaceW = 10;
    CGFloat spaceH = 15;
    CGFloat * labelWidth = 40;
    
    NSArray * titleArr = @[@"姓名：",@"手机：",@"车牌：",@"车型："];
    
    
    
    
//    显示用户名
    self.phoneNumber.text = [[NSUserDefaults standardUserDefaults]objectForKey:USER_NAMEORPHONE];
//    设置套餐表格的属性
    self.taoCanTabelView.scrollEnabled = NO;
    self.taoCanTabelView.delegate = self;
    self.taoCanTabelView.dataSource = self;
    [self.taoCanTabelView registerNib:[UINib nibWithNibName:@"TaoCanCell" bundle:nil] forCellReuseIdentifier:identifierForTaoCanCell];
    self.taoCanTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //    姓名输入栏--代理--清除键
    self.userName.delegate = self;
    self.userName.keyboardType = UIKeyboardTypeDefault;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //    电话输入栏--代理--键盘--清除键
    self.phoneNumber.delegate = self;
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    支付按钮--圆角--添加事件
    self.buyBtn.layer.cornerRadius = 10;
    self.buyBtn.layer.masksToBounds = YES;
    [self.buyBtn addTarget:self action:@selector(zhiFuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //    车牌文本框--圆角
    self.dangQianChePaiLabel.layer.cornerRadius = 5;
    self.dangQianChePaiLabel.layer.masksToBounds = YES;
    
    
    //    车型文本框--圆角--行数--文字自适应
    self.dangQianCheXingLabel.layer.cornerRadius = 5;
    self.dangQianCheXingLabel.layer.masksToBounds = YES;
    self.dangQianCheXingLabel.numberOfLines = 0;
    self.dangQianCheXingLabel.adjustsFontSizeToFitWidth = YES;
    
    
    //    选车按钮--圆角--添加事件
    self.xuanCheBtn.layer.cornerRadius = 10;
    self.xuanCheBtn.layer.masksToBounds = YES;
    [self.xuanCheBtn addTarget:self action:@selector(qieHuanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

//数据处理
#pragma mark
#pragma mark -Data
/**
 *加载数据
 */
-(void)loadData
{
    //    套餐信息
    _taoCanArr = @[@"致享组合",@"致信组合",@"致尚组合"];//名称
    _taoCanPriceArr = @[@"588.00",@"988.00",@"1488.00"];//价格
    _priceArr = @[@588.00,@988.00,@1488.00];//价格数组
    //    判断上次使用车型
    if ([[NSUserDefaults standardUserDefaults]objectForKey:USER_CHEPAI] == nil) {
        [self.xuanCheBtn setTitle:@"添加车牌" forState:UIControlStateNormal];
        self.dangQianChePaiLabel.text = @"(空)";
        self.dangQianCheXingLabel.text = @"(空)";
    }else
    {
        if (![self.dangQianChePaiLabel.text isEqualToString:@"(空)"] ) {
            [MBProgressHUD showSuccess:@"匹配推荐套餐！"];
        }
        self.dangQianChePaiLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:USER_CHEPAI];
        self.dangQianCheXingLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:USER_CHEXING];
        _taoCanType = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TAOCANTYPE];
    }
    [self.taoCanTabelView reloadData];
}
/**
 *刷新数据
 */
-(void)freshData
{
    [MBProgressHUD showSuccess:@"匹配推荐套餐！"];
    self.dangQianChePaiLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:USER_CHEPAI];
    self.dangQianCheXingLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:USER_CHEXING];
    _taoCanType = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TAOCANTYPE];
    [self.taoCanTabelView reloadData];
}

//逻辑功能
#pragma mark
#pragma mark -Function
/**
 *点击切换车牌
 */
-(IBAction)qieHuanBtnClicked:(UIButton *)btn
{
    if ([self.phoneNumber isFirstResponder] || [self.userName isFirstResponder]) {
        [self.phoneNumber resignFirstResponder];
        [self.userName resignFirstResponder];
    }else
    {
//        XuanZeVC * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"XuanZeVC"];
//        
//        
//        
//        [self.navigationController pushViewController:VC animated:YES];
//        
//        
//        VC.tiaoZhuanZhuangTai = @"0";
        
        
        JSXPCheKuViewController * View = [[JSXPCheKuViewController alloc]init];
        
        [self.navigationController pushViewController:View animated:YES];
        
        View.tiaoZhuanZhuangTai = @"0";
    }
}
/**
 *文本框放弃第一响应
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumber resignFirstResponder];
    [self.userName resignFirstResponder];
}
/**
 *去支付
 */
-(IBAction)zhiFuBtnClicked:(UIButton *)btn
{
    //    判断所有信息是否完整
    if (self.phoneNumber.text != nil && ![self.phoneNumber.text isEqualToString:@""]&&self.userName.text != nil && ![self.userName.text isEqualToString:@""]&&self.dangQianChePaiLabel.text != nil && ![self.dangQianChePaiLabel.text isEqualToString:@""]&& ![self.dangQianChePaiLabel.text isEqualToString:@"(空)"]&&self.dangQianCheXingLabel.text != nil && ![self.dangQianCheXingLabel.text isEqualToString:@""]&&![self.dangQianCheXingLabel.text isEqualToString:@"(空)"])
    {
        [MBProgressHUD showMessage:@"订单生成中……"];
        [[NET new]getDataWithDic:@{@"actionname":@"GoBuy",@"UId":[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID],@"CarTypeId":[[NSUserDefaults standardUserDefaults] objectForKey:USER_CHEXINGID],@"Pid":_taoCanType} CompelementHandle:^(id data)
         {
             JSDingDanXinXiModel * model = data;
             if ([model.retMsg isEqualToString:@"购买成功！"])
             {
                 [MBProgressHUD hideHUD];
                 [[NSUserDefaults standardUserDefaults] setObject:model.orderId forKey:USER_ORDERID];
                 [[NSUserDefaults standardUserDefaults] setObject:_priceArr[_taoCanJiaGe] forKey:USER_PRICE];
                 //跳转到支付界面
                 JSZhiFuVC * ZFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JSZhiFuVC"];
                 [self.navigationController pushViewController:ZFVC animated:YES];
                 //传递支付信息
                 ZFVC.taoCanName = [NSString  stringWithFormat:@"￥: %@",(NSString *)_taoCanPriceArr[_taoCanJiaGe]];
             }else
             {
                 [MBProgressHUD showError:@"购买失败！"];
             }
         }];
    }
    else//信息不全
    {
        [MBProgressHUD showError:@"信息不全"];
    }
}


//代理区域
#pragma mark
#pragma mark -Delegate
// 当正在输入的时候会执行此方法
// param: range 是表示当前输入的位置
//        string 是表示当前输入的单个字符(unichar)内容
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneNumber)
    {
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 11) return NO;//限制长度
        return YES;
    }
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _taoCanArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.taoCanTabelView.frame.size.height >= 120) {
        return 40;
    }else
    {
        return self.taoCanTabelView.frame.size.height/3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaoCanCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForTaoCanCell];
    cell.taoCan.text = _taoCanArr[indexPath.row];
    cell.taoCanPrice.text = _taoCanPriceArr[indexPath.row];
//    根据套餐属性进行数据连动
    if ([_taoCanType isEqualToString:@"7"]&&indexPath.row == 0)
    {
        [cell.taoCanImage setImage:[UIImage imageNamed:@"chose2"]];
        _taoCanJiaGe = indexPath.row;
    }else if ([_taoCanType isEqualToString:@"6"]&&indexPath.row == 1)
    {
        [cell.taoCanImage setImage:[UIImage imageNamed:@"chose2"]];
        _taoCanJiaGe = indexPath.row;
    }else if ([_taoCanType isEqualToString:@"5"]&&indexPath.row == 2)
    {
        [cell.taoCanImage setImage:[UIImage imageNamed:@"chose2"]];
        _taoCanJiaGe = indexPath.row;
    }else
    {
        [cell.taoCanImage setImage:[UIImage imageNamed:@"chose1"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.phoneNumber isFirstResponder] || [self.userName isFirstResponder]) {
        [self.phoneNumber resignFirstResponder];
        [self.userName resignFirstResponder];
    }
    if (indexPath.row == 0)
    {
        _taoCanType = @"7";
        [self.taoCanTabelView reloadData];
    }else if (indexPath.row == 1)
    {
        _taoCanType = @"6";
        [self.taoCanTabelView reloadData];
    }else if (indexPath.row == 2)
    {
        _taoCanType = @"5";
        [self.taoCanTabelView reloadData];
    }
    _taoCanJiaGe = indexPath.row;
}
//三方工具
#pragma mark
#pragma mark -Third-Party

@end
