//
//  DataService.h
//  XinPei
//
//  Created by 醉卧沙场君莫笑 on 16/3/21.
//  Copyright © 2016年 glory.js.com. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^CompeleteHandler)(id data);

@interface DataService : NSObject

/**
*获取超值组合界面数据
*通过参数Paramenter
*返回数据Data
*/
-(void)getBargainDataWithParamenter:(NSString *)string
                   andWithCompelete:(CompeleteHandler)handler;



/**
上传
 */
-(void)uodateDataWithBody:(NSString *)string
                   andWithCompelete:(CompeleteHandler)handler;
@end
