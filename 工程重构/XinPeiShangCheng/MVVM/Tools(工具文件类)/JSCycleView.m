//
//  JSCycleView.m
//  XinPeiShangChengVersion1
//
//  Created by BankWong on 16/5/27.
//  Copyright © 2016年 BankWong. All rights reserved.
//

#import "JSCycleView.h"


#define SPACE_H 2
#define SPACE_W 10


@implementation JSCycleView

-(void)creatControllersWithCycleType:(CycleType)cycleType
                        withTitleArr:(NSArray *)titleArr
                    withImageNameArr:(NSArray *)imageNameArr
                       withButtonArr:(NSArray *)buttonArr
                           withCross:(int)cross
{
    
    int vertical;
    if (titleArr.count != 0) {
        if (titleArr.count % cross == 0) {
            vertical = (int)titleArr.count / cross;
        }else
        {
            vertical = (int)titleArr.count / cross + 1;
        }
    }else if(imageNameArr.count != 0)
    {
        if (imageNameArr.count % cross == 0) {
            vertical = (int)imageNameArr.count / cross;
        }else
        {
            vertical = (int)imageNameArr.count / cross + 1;
        }
    }else
    {
        if (buttonArr.count % cross == 0) {
            vertical = (int)buttonArr.count / cross;
        }else
        {
            vertical = (int)buttonArr.count / cross + 1;
        }
    }
    
    CGFloat width = (self.frame.size.width - SPACE_W * (cross +1))/cross;
    CGFloat height = (self.frame.size.height - SPACE_H * (vertical +1))/vertical;
    
    
    switch (cycleType) {
        case TypeLabel:
            [self creatLabelWithTitleArr:titleArr withCross:cross withVertical:vertical withWidth:width withHeight:height];
            break;
        case TypeImage:
            [self creatImagelWithImageArr:imageNameArr withCross:cross withVertical:vertical withWidth:width withHeight:height];
            break;
        case TypeButton:
            [self creatButtonlWithButtonArr:buttonArr withCross:cross withVertical:vertical withWidth:width withHeight:height withTitleArr:titleArr withImageArr:imageNameArr];
            break;
        default:
            break;
    }
    
    
    
}

-(void)creatLabelWithTitleArr:(NSArray *)titleArr
                    withCross:(int)cross
                 withVertical:(int)vertical
                    withWidth:(CGFloat)width
                   withHeight:(CGFloat)height
{
    int cro = 0;
    int ver = 0;
    for (int i = 0; i < titleArr.count; i ++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SPACE_W + cro * (width+SPACE_W), SPACE_H + ver * (height+SPACE_H), width, height)];
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:label];
        cro ++;
        if (cro == cross) {
            cro = 0;
            ver ++;
        }
    }
}

-(void)creatImagelWithImageArr:(NSArray *)imageArr
                    withCross:(int)cross
                 withVertical:(int)vertical
                    withWidth:(CGFloat)width
                   withHeight:(CGFloat)height
{
    int cro = 0;
    int ver = 0;
    for (int i = 0; i < imageArr.count; i ++) {
        if (imageArr.count > 0) {
            UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArr[i]]];
            image.frame = CGRectMake(SPACE_W + cro * (width+SPACE_W), SPACE_H + ver * (height+SPACE_H), width, height);
            [self addSubview:image];
        }
        cro ++;
        if (cro == cross) {
            cro = 0;
            ver ++;
        }
    }
}

-(void)creatButtonlWithButtonArr:(NSArray *)buttonArr
                       withCross:(int)cross
                    withVertical:(int)vertical
                       withWidth:(CGFloat)width
                      withHeight:(CGFloat)height
                    withTitleArr:(NSArray *)titleArr
                    withImageArr:(NSArray *)imageArr
{
    int cro = 0;
    int ver = 0;
    for (int i = 0; i < imageArr.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SPACE_W + cro * (width+SPACE_W), SPACE_H + ver * (height+SPACE_H), width, height);
        if (titleArr.count > 0) {
            [button setTitle:titleArr[i] forState:UIControlStateNormal];
        }
        if (imageArr.count > 0) {
            [button setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        }
        
        [self addSubview:button];
        cro ++;
        if (cro == cross) {
            cro = 0;
            ver ++;
        }
    }
}


@end
