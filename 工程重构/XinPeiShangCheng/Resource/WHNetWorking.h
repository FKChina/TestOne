//
//  WHNetWorking.h
//  登录注册
//
//  Created by 杭州信配 on 16/3/30.
//  Copyright © 2016年 com.hzxp.xpPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHNetWorking : NSObject

//get方式
+(void)operationManagerGET:(NSString *)url parameters:(id )params WithReturnValeuBlock: (ReturnValueBlock) block
        WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
          WithFailureBlock: (FailureBlock) failureBlock;

@end
