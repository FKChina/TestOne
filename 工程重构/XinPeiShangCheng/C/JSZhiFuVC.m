//
//  JSZhiFuVC.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/5.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSZhiFuVC.h"

static NSString * identifierForZhiFuCell = @"identifierZhiFuCell";

@interface JSZhiFuVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _imageOneArr;
}

@property (strong ,nonatomic) NSArray * fangShiArr;

@property (assign ,nonatomic) BOOL isTongyi;

@property (copy ,nonatomic) NSString * zFType;

@end

@implementation JSZhiFuVC

-(void)viewWillAppear:(BOOL)animated
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:ZHIFU_STATU] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:ZHIFU_STATU];
//        修改订单状态
        
        XPJSActivityIndicatorView * juhua = [[XPJSActivityIndicatorView alloc]initWithPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT_WNavigation(1)/2)];
        [juhua startAnimating];
        
        NSDictionary * dicTemplate =  @{@"actionname":@"Update_Order",//修改订单状态
                                        @"OrderId":[[NSUserDefaults standardUserDefaults]objectForKey:USER_ORDERID],//订单ID
                                        @"FKstate":@"1",//付款状态0未付款1
                                        @"ZFType":_zFType,//支付方式
                                        @"Operator":[[NSUserDefaults standardUserDefaults]objectForKey:  USER_UID],//操作人
                                        @"Payer":[[NSUserDefaults standardUserDefaults]objectForKey:  USER_UID]//付款人
                                        };
        
        [[NET new]getDataWithDictionary:dicTemplate WithJSReturnDataBlock:^(id data) {
            [juhua stopAnimating];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } WithJSErrorMessageBlock:^(id errorMessage) {
            
        } WithJSFailureMessageBlock:^(id failureMessage) {
            
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark View_Life_Cycle

#pragma mark
#pragma mark MemoryWarning

#pragma mark
#pragma mark UI
-(void)configUI
{
    
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:USER_ISREFRASH];
    _isTongyi = YES;
    self.zhiFuTable.delegate = self;
    self.zhiFuTable.dataSource = self;
    self.zhiFuTable.scrollEnabled = NO;

    
    [self.zhiFuTable registerNib:[UINib nibWithNibName:@"JSZhiFuCell" bundle:nil] forCellReuseIdentifier:identifierForZhiFuCell];
    self.zhiFuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zhiFuJiaGeLabel.text = self.taoCanName;
    [self.tongYiBtn addTarget:self action:@selector(tongYiBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tongYiBtn setImage:[UIImage imageNamed:@"cxt2"] forState:UIControlStateNormal];
    [self.queRenAnNiu addTarget:self action:@selector(queRenBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark
#pragma mark Data
-(void)loadData
{
    _imageOneArr = @[@"未标题-1",@"bigImage_green",@"现金"];
    _fangShiArr = @[@"微信支付",@"支付宝支付",@"现场支付"];
}
#pragma mark
#pragma mark Action
-(IBAction)tongYiBtnClicked:(UIButton *)btn
{
    _isTongyi = !_isTongyi;
    
    if (_isTongyi) {
        [self.tongYiBtn setImage:[UIImage imageNamed:@"cxt2"] forState:UIControlStateNormal];
    }else
    {
        [self.tongYiBtn setImage:[UIImage imageNamed:@"cxt1"] forState:UIControlStateNormal];
    }
}

-(IBAction)queRenBtn:(id)sender
{
    [MBProgressHUD showError:@"请选择一种支付方式！"];
}
//微信支付
-(IBAction)weiXinZhiFu:(UIButton *)btn
{
//    成功
    if (_isTongyi) {
        
        _zFType = @"0";
//        微信支付

    }else
    {
        [MBProgressHUD showError:@"请同意用户协议！"];
    }

}

//支付宝支付
-(IBAction)zhiFuBaoZhiFu:(UIButton *)btn
{
    
    if (_isTongyi)
    {
        _zFType = @"1";
        [AlipayRequestConfig alipayWithPartner:XPPartnerID
                                        seller:XPSeller
                                       tradeNO:[AlipayToolKit genTradeNoWithTime]
                                   productName:self.productName
                            productDescription:self.productDescription
                                        amount:self.productPrice
                                     notifyURL:XPNotifyURL];
    }else
    {
        [MBProgressHUD showError:@"请同意用户协议！"];
    }
}
//线下支付
-(IBAction)xianXiaZhiFu:(UIButton *)btn
{
    
    if (_isTongyi) {
        _zFType = @"2";
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:ZHIFU_STATU];
    }else
    {
        [MBProgressHUD showError:@"请同意用户协议！"];
    }
    }
#pragma mark
#pragma mark Function



#pragma mark
#pragma mark Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSZhiFuCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForZhiFuCell forIndexPath:indexPath];
    [cell.imageOne setImage:[UIImage imageNamed:_imageOneArr[indexPath.row]]];
    [cell.imageTwo setImage:[UIImage imageNamed:@"chose1"]];
    cell.zhiFuFangShi.text = _fangShiArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imageOneArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSZhiFuCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.imageTwo setImage:[UIImage imageNamed:@"chose2"]];
    
    
    if (indexPath.row == 0)
    {
//        切换成微信支付
        [self.queRenAnNiu removeTarget:self action:@selector(zhiFuBaoZhiFu:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu removeTarget:self action:@selector(xianXiaZhiFu:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu removeTarget:self action:@selector(queRenBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu addTarget:self action:@selector(weiXinZhiFu:) forControlEvents:UIControlEventTouchUpInside];
    }else if (indexPath.row == 1)
    {
//        切换成支付宝支付
        [self.queRenAnNiu removeTarget:self action:@selector(weiXinZhiFu:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu removeTarget:self action:@selector(xianXiaZhiFu:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu removeTarget:self action:@selector(queRenBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu addTarget:self action:@selector(zhiFuBaoZhiFu:) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
//        切换成线下支付
        [self.queRenAnNiu removeTarget:self action:@selector(weiXinZhiFu:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu removeTarget:self action:@selector(zhiFuBaoZhiFu:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu removeTarget:self action:@selector(queRenBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.queRenAnNiu addTarget:self action:@selector(xianXiaZhiFu:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSZhiFuCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.imageTwo setImage:[UIImage imageNamed:@"chose1"]];
}
@end
