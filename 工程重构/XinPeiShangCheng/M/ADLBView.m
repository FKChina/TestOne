//
//  ADLBView.m
//  day15-03-广告轮播封装
//
//  Created by Aaron on 15/10/23.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import "ADLBView.h"


#import <UIImageView+AFNetworking.h>


@interface ADLBView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *adView;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) NSArray *titel;

@property (nonatomic,strong) void (^callBack)(NSInteger chooseIndex);

@end

@implementation ADLBView

-(instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images withTitle:(NSArray *)title withCallBack:(void(^)(NSInteger chooseIndex))callBack
{
    if(self = [super initWithFrame:frame])
    {
        _titel = title;
        _images = images;
        _callBack = callBack;
        [self configUI];
        [self createBtn];
        
        
//        [self startScroll];
    }
    return self;

}

#pragma mark 搭建整体UI
-(void)configUI
{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseOne:)];
    
    [self addGestureRecognizer:tap];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    
    scrollView.backgroundColor = [UIColor whiteColor];
    _adView = scrollView;
    
    _imageViews = [NSMutableArray array];
    for(int i = 0; i < 3; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        [scrollView addSubview:imgView];
        [_imageViews addObject:imgView];
    }
    
    scrollView.bounces = NO;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width*3, scrollView.bounds.size.height);
    
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    [self showImageByIndex:_currentIndex];
}
#pragma mark 根据位置来插入图片
-(void)showImageByIndex:(NSInteger)index
{
    for(int i = -1;i <= 1; i++)
    {
        UIImageView *imgView = _imageViews[i+1];
        imgView.image = _images[[self trueIndexFromIndex:index+i]];
    }
}

#pragma mark 真实位置
-(NSInteger)trueIndexFromIndex:(NSInteger)index
{
    if(index==-1)
    {
        return _images.count-1;
    }
    else if(index == _images.count)
    {
        return 0;
    }
    return index;
}


#pragma mark 根据广告图片数量创建btn
-(void)createBtn
{
    _btnArray = [NSMutableArray array];
    for(int i = 0; i < _images.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:_titel[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;

        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [self addSubview:btn];
        [_btnArray addObject:btn];
    }
    
    [self reloadBtnCenter];
    [self changePageImageByIndex:_currentIndex];
}

#pragma mark 广告滚动计时器
-(void)startScroll
{
    if(!_timer)
    {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}
#pragma mark 广告滚动
-(void)timerRun
{
    [UIView animateWithDuration:0.5 animations:^{
        _adView.contentOffset = CGPointMake(_adView.bounds.size.width*2, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:_adView];
    }];
}

-(void)chooseOne:(UITapGestureRecognizer *)tap
{
    _callBack(_currentIndex);
}


-(void)dismissMe:(UIButton *)sender
{
    [self removeFromSuperview];
}


#pragma mark 设施btn图标和内容
-(void)changePageImageByIndex:(NSInteger)index
{
    for(int i = 0; i < _images.count;i++)
    {
        UIButton *btn = _btnArray[i];
        if(i == index)
        {
//            选中状态btn
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        else
        {
//            非选中状态btn
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
#pragma mark 改变btn位置
-(void)reloadBtnCenter
{
    for(NSInteger i = 0; i < _btnArray.count; i++)
    {
        
        UIButton *btn = _btnArray[i];
        btn.frame = CGRectMake(SCREEN_WIDTH/2 - ((float)_btnArray.count * ADVERTISEMENT_HEIGHT_PAGE_WIDTH + ((float)_btnArray.count -1) * ADVERTISEMENT_HEIGHT_PAGE_HEIGHT)/2 + (ADVERTISEMENT_HEIGHT_PAGE_HEIGHT + ADVERTISEMENT_HEIGHT_PAGE_WIDTH)*i, self.bounds.size.height-_boardWidth.bottom-20-10, ADVERTISEMENT_HEIGHT_PAGE_WIDTH, ADVERTISEMENT_HEIGHT_PAGE_HEIGHT);
        
    }
}
#pragma mark 滑动视图结束滑动

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;

    if(contentOffset.x == 0)
    {
        _currentIndex = [self trueIndexFromIndex:_currentIndex-1];
    }
    else if(contentOffset.x == scrollView.bounds.size.width*2)
    {
        _currentIndex = [self trueIndexFromIndex:_currentIndex+1];
    }
    [self showImageByIndex:_currentIndex];
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    [self changePageImageByIndex:_currentIndex];
}
-(void)setBoardWidth:(UIEdgeInsets)boardWidth
{
    _boardWidth = boardWidth;
    _adView.frame = CGRectMake(_boardWidth.left, _boardWidth.top, self.bounds.size.width-_boardWidth.left-_boardWidth.right, self.bounds.size.height-_boardWidth.bottom-_boardWidth.top);

    for(int i = 0; i < _imageViews.count;i++)
    {
        UIImageView *imageView = _imageViews[i];
        imageView.frame = CGRectMake(_adView.bounds.size.width*i, 0, _adView.bounds.size.width, _adView.bounds.size.height);
    }

    _adView.contentOffset = CGPointMake(_adView.bounds.size.width, 0);

    _adView.contentSize = CGSizeMake(_adView.bounds.size.width*3, _adView.bounds.size.height);

    [self reloadBtnCenter];
}

-(void)setBoardColor:(UIColor *)boardColor
{
    _boardColor = boardColor;
    self.backgroundColor = _boardColor;
}
-(void)reloadBtn
{
    for(NSInteger i = 0; i < _btnArray.count; i++)
    {
        UIButton *btn = _btnArray[_btnArray.count-1-i];
        btn.frame = CGRectMake(self.bounds.size.width-_boardWidth.right-20-10-(5+10)*i, self.bounds.size.height-_boardWidth.bottom-10-10, 20, 10);
    }
}

@end
