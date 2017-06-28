//
//  ZCNetRequestTool.m
//  News
//
//  Created by wqs on 16/6/5.
//  Copyright (c) 2016年 yzc. All rights reserved.
//

#import "ZCNetRequestTool.h"
#import <AFNetworking.h>

@interface ZCNetRequestTool()



@end


//使用AFNetworking 检测网络  发送GET请求 POST请求

@implementation ZCNetRequestTool
+ (instancetype)sharedZCNetRequestTool {
    static ZCNetRequestTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ZCNetRequestTool new];
    });
    return instance;
}
- (void)setBlockWithNetworkBlock: (NetWorkBlock) networkBlock {
    _networkBlock = networkBlock;
}



#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //取消挂起
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                //挂起
                [operationQueue setSuspended:YES];
                break;
        }
        //使用block将网络状态传出来
        ZCNetRequestTool *tool = [ZCNetRequestTool sharedZCNetRequestTool];
        if (tool.networkBlock) {
            tool.netWorkCanUse = netState;
            tool.networkBlock(netState);
        }
        
    }];
    
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}


/***************************************
 在这做判断如果有dic里有errorCode
 调用errorBlock(dic)
 没有errorCode则调用block(dic)
 ******************************/

#pragma --mark GET请求方式
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                   WithNetworkBlock: (NetWorkBlock) networkBlock
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置网络超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:requestURLString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            if (block) {
                //回传结果
                block(jsonDic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            //请求失败
            errorBlock(error);
        }
    }];
    
    
    
}

#pragma --mark POST请求方式

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (ReturnValueBlock) block
                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithNetworkBlock: (NetWorkBlock) networkBlock
{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置网络超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:requestURLString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            if (block) {
                block(jsonDic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];

    
}

@end
