//
//  ZCNetRequestTool.h
//  News
//
//  Created by wqs on 16/6/5.
//  Copyright (c) 2016年 yzc. All rights reserved.
//

#import <Foundation/Foundation.h>


//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
//typedef void (^FailureBlock)();
typedef void (^NetWorkBlock) (BOOL netConnetState);

@interface ZCNetRequestTool : NSObject

@property (copy, nonatomic) NetWorkBlock networkBlock;


@property (nonatomic, getter=isNetWorkCanUse) BOOL netWorkCanUse;

//单例方法
+ (instancetype)sharedZCNetRequestTool;


- (void)setBlockWithNetworkBlock: (NetWorkBlock) networkBlock;

#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma POST请求
+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (ReturnValueBlock) block
                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithNetworkBlock: (NetWorkBlock) networkBlock;

#pragma GET请求
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithNetworkBlock: (NetWorkBlock) networkBlock;

@end
