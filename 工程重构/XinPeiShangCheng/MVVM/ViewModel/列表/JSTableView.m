//
//  JSTableView.m
//  XinPeiShangCheng
//
//  Created by BankWong on 16/5/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSTableView.h"

@interface JSTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray * dataArr;//数据源

@end

@implementation JSTableView


-(void)configUI
{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}


//视图周期
#pragma mark
#pragma mark View_Life_Cycle

//界面搭建
#pragma mark
#pragma mark UI

//数据源
#pragma mark
#pragma mark Data

//逻辑处理
#pragma mark
#pragma mark Function

//相应事件
#pragma mark
#pragma mark Action

//执行代理
#pragma mark
#pragma mark Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    return 10;
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

//内存管理
#pragma mark
#pragma mark MemoryWarning


@end
