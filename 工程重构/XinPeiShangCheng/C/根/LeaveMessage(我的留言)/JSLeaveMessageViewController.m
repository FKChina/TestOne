//
//  JSLeaveMessageViewController.m
//  XinPeiShangCheng
//
//  Created by 醉卧沙场君莫笑 on 16/4/28.
//  Copyright © 2016年 www.xinpeiauto.com. All rights reserved.
//

#import "JSLeaveMessageViewController.h"

static NSString * const identifierForLiuYanCell = @"liuYanCell";


@interface JSLeaveMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITextView * textView;

@property (nonatomic ,strong) WHButton * liuYanBtn;

@property (nonatomic ,strong) UITableView * liuYanTableView;

@property (nonatomic , strong) NSArray * dataArr;

@property (nonatomic , strong) JSBaseLabel * liuYanXuanZe;


@end

@implementation JSLeaveMessageViewController



//视图周期
#pragma mark
#pragma mark -View_Life_Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat toTop = 20;
    CGFloat toLift = 10;
    CGFloat jiFenViewWidth = SCREEN_WIDTH;
    CGFloat jiFenViewHeight = SCREEN_HEIGHT/15;
    
    
    //    积分视图标题
    JSBaseLabel * titleLabel = [[JSBaseLabel alloc]initWithFrame:CGRectMake(toLift, toTop, jiFenViewWidth/2, jiFenViewHeight)];
    
    [titleLabel setLabelTitle:@"我的留言板" TitleColor:[UIColor redColor] BackGroundColor:[UIColor clearColor] font:17 cornerRadius:jiFenViewHeight/2 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    WHButton * wpYaoLiuYanBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    wpYaoLiuYanBtn.frame = CGRectMake(jiFenViewWidth/4, jiFenViewHeight, jiFenViewWidth/4, jiFenViewHeight/2);
    [wpYaoLiuYanBtn setButtonTitle:@"我要留言" TitleColor:[UIColor blackColor] BackGroundColor:[UIColor whiteColor] font:12 cornerRadius:jiFenViewHeight/2];
    [wpYaoLiuYanBtn addTarget:self action:@selector(woYaoLiuYanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wpYaoLiuYanBtn];
    
    
    WHButton * historyBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(jiFenViewWidth/2, jiFenViewHeight, jiFenViewWidth / 4, jiFenViewHeight/2);
    [historyBtn setButtonTitle:@"查看留言记录" TitleColor:[UIColor lightGrayColor] BackGroundColor:[UIColor whiteColor] font:12 cornerRadius:jiFenViewHeight/2];
    [historyBtn addTarget:self action:@selector(historyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyBtn];
    
    
    //    积分视图名称
    _liuYanXuanZe = [[JSBaseLabel alloc]initWithFrame:CGRectMake(jiFenViewWidth/4, jiFenViewHeight + jiFenViewHeight/2, jiFenViewWidth/2, jiFenViewHeight/2)];
    _liuYanXuanZe.textAlignment = NSTextAlignmentCenter;
    [_liuYanXuanZe setLabelTitle:@"留言内容" TitleColor:[UIColor blackColor] BackGroundColor:[UIColor clearColor] font:12 cornerRadius:jiFenViewHeight/2 boardSize:0 boardColor:nil textAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:_liuYanXuanZe];
    
    
//    我的留言
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(toLift * 3 , jiFenViewHeight * 2  , jiFenViewWidth - toLift * 6 , jiFenViewHeight * 4 )];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds =YES;
    _textView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _textView.layer.borderWidth = 1;
    [self.view addSubview:_textView];
    
    
    
    _liuYanBtn = [WHButton buttonWithType:UIButtonTypeCustom];
    _liuYanBtn.frame = CGRectMake(toLift * 2, jiFenViewHeight * 7, jiFenViewWidth - toLift * 4, jiFenViewHeight);
    [_liuYanBtn setButtonTitle:@"留言" TitleColor:[UIColor whiteColor] BackGroundColor:[UIColor lightGrayColor] font:17 cornerRadius:jiFenViewHeight/2];
    [_liuYanBtn setBornerWidth:1 color:[UIColor blackColor]];
    [_liuYanBtn addTarget:self action:@selector(liuYanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_liuYanBtn];
    
    
    
    _liuYanTableView = [[UITableView alloc]initWithFrame:CGRectMake(toLift * 3 , jiFenViewHeight * 2  , jiFenViewWidth - toLift * 6 , jiFenViewHeight * 6 ) style:UITableViewStylePlain];
    _liuYanTableView.delegate = self;
    _liuYanTableView.dataSource = self;
    _liuYanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_liuYanTableView registerClass:[JSLiuYanTableViewCell class] forCellReuseIdentifier:identifierForLiuYanCell];
    _liuYanTableView.layer.cornerRadius = 5;
    _liuYanTableView.layer.masksToBounds =YES;
    _liuYanTableView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _liuYanTableView.layer.borderWidth = 1;
    
    
}
//数据处理
#pragma mark
#pragma mark -Data

//界面跳转
#pragma mark
#pragma mark -Push
/**
 *  我要留言按钮
 *
 *  @param sender 按钮
 */
-(IBAction)woYaoLiuYanBtnClicked:(id)sender
{
    [_liuYanTableView removeFromSuperview];
    
    _liuYanXuanZe.text = @"留言内容";
    for(UIView *view in self.view.subviews)
    {
        if(![view isKindOfClass:[_liuYanBtn class]])
        {
            [self.view addSubview:_liuYanBtn];
        }
        if(![view isKindOfClass:[_textView class]])
        {
            [self.view addSubview:_textView];
        }
    }
}

/**
 *  查看历史留言记录btn
 *
 *  @param sender 按钮
 */
-(IBAction)historyBtnClicked:(id)sender
{
    [_textView removeFromSuperview];
    [_liuYanBtn removeFromSuperview];
    _liuYanXuanZe.text = @"我的留言记录";
    for(UIView *view in self.view.subviews)
    {
        if(![view isKindOfClass:[_liuYanTableView class]])
        {
            [self.view addSubview:_liuYanTableView];
        }
        
    }
}
//逻辑功能
#pragma mark
#pragma mark -Function

-(IBAction)liuYanBtnClicked:(id)sender
{
    if (_textView.text.length != 0 && _textView != 0) {
        UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.hidesWhenStopped = YES;
        [activityView startAnimating];
        
        
        activityView.center = CGPointMake(_textView.bounds.size.width * 0.5, _textView.bounds.size.height * 0.5);
        
        
        [_textView addSubview:activityView];
        
        [[NET new]getDataWithDictionary:@{@"actionname":@"Add_Message",@"messageconten":_textView.text,@"Uid":[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]} WithJSReturnDataBlock:^(id data)
        {
            for (NSString * key in data) {
                NSLog(@"%@",key);
                NSLog(@"%@",[data objectForKey:key]);
            }
            if ([[data objectForKey:@"statecode"] isEqualToString:@"1"])
            {
                [activityView stopAnimating];
                _textView.text = @"";
                [MBProgressHUD showSuccess
                 :@"留言成功"];
                _textView.text = @"";
            }else
            {
                [activityView stopAnimating];
                [MBProgressHUD showError:@"留言失败!"];
            }
        } WithJSErrorMessageBlock:^(id errorMessage) {
            [activityView stopAnimating];
            [MBProgressHUD showError:@"留言失败!"];
        } WithJSFailureMessageBlock:^(id failureMessage) {
            [activityView stopAnimating];
            [MBProgressHUD showError:@"留言失败!"];
        }];
    }else
    {
        [MBProgressHUD showError:@"留言内容不能为空!"];
    }
}
//代理区域
#pragma mark
#pragma mark -Delegate



#pragma mark Required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSLiuYanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierForLiuYanCell forIndexPath:indexPath];
    return cell;
}

#pragma mark Optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}





//三方工具
#pragma mark
#pragma mark -Third-Party
@end
