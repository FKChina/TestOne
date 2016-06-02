//
//  JSCycleView.h
//  XinPeiShangChengVersion1
//
//  Created by BankWong on 16/5/27.
//  Copyright © 2016年 BankWong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TypeLabel,
    TypeImage,
    TypeButton
}CycleType;





@interface JSCycleView : UIView



-(void)creatControllersWithCycleType:(CycleType)cycleType
                        withTitleArr:(NSArray *)titleArr
                    withImageNameArr:(NSArray *)imageNameArr
                    withButtonArr:(NSArray *)buttonArr
                           withCross:(int)cross;


@end
