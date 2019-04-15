//
//  YJNetworkData.m
//  YJJSApp
//
//  Created by DT on 2018/3/21.
//  Copyright © 2018年 dt. All rights reserved.
//

#import "YJNetworkData.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "IHUtility.h"
#import "Contant.h"
#import "WHToast.h"
#import "NSObject+SBJSON.h"
#import "SessionManager.h"
@implementation YJNetworkData
static YJNetworkData *_config;
+(YJNetworkData *)shareInstance{
    @synchronized(self){
        if (_config==nil) {
            _config=[[YJNetworkData alloc] init];
        }
    }
    return _config;
}
//根据tag 来封装数据
-(void)httpRequestTagWithParameter:(NSDictionary *)dic
                             method:(NSString *)method
                            tag:(IHFunctionTag)tag
                        success:(void (^)(id))success
                        failure:(void (^)(id))failure{

    AFHTTPSessionManager *sessionManager = [SessionManager shareManager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *  service = [NSString stringWithFormat:@"%@%@",serStrURL,method];
    [sessionManager POST:service parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JSONDecoder *jd=[[JSONDecoder alloc] init];
            NSDictionary *ret = [jd objectWithData: responseObject];
             NSInteger errorNo=[[ret objectForKey:@"code"]integerValue];
           
            if(errorNo!=0){
                [IHUtility removeWaitingView];
                [WHToast showMessage:[ret objectForKey:@"msg"] duration:1 finishHandler:^{
                }];
                 failure(ret);
            }else
            {
                NSDictionary *dic2=[self parseResult:ret tag:nil];
                success(dic2);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary *userInfo=error.userInfo;
        [WHToast showMessage:[userInfo objectForKey:@"NSLocalizedDescription"] duration:1 finishHandler:^{
        }];
        failure(error);
    }];
}
-(void)httpRequestWithParameterWithGet:(NSString *)method success:(void (^)(id))success
{
 AFHTTPSessionManager *sessionManager = [SessionManager shareManager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    [sessionManager.requestSerializer setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    NSString * service = [NSString stringWithFormat:@"%@%@",serStrURL,method];
    if([method isEqualToString:@"https://sts.gezhongxinqun1.com/"]){
        service =@"https://sts.gezhongxinqun1.com/";
    }
    [sessionManager GET:service parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSData * xmlData = (NSData *)responseObject;
            if(xmlData.bytes > 0){
                JSONDecoder *jd=[[JSONDecoder alloc] init];
                NSString *resultString  =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSDictionary *ret = [jd objectWithData: responseObject];
                if(ret!=nil){
                    NSInteger errorNo=[[ret objectForKey:@"code"]integerValue];
                    if(errorNo!=0){
                        [IHUtility removeWaitingView];
                        [WHToast showMessage:[ret objectForKey:@"msg"] duration:1 finishHandler:^{
                        }];
        
                    }else
                    {
                        NSDictionary *dic2=[self parseResult:ret tag:nil];
                        success(dic2);
                    }
                }else
                {
                    success(resultString);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary *userInfo=error.userInfo;
        [WHToast showMessage:[userInfo objectForKey:@"NSLocalizedDescription"] duration:1 finishHandler:^{
        }];
    }];
}
//根据tag 来封装数据
-(void)httpRequestTagWithServer:(NSDictionary *)dic
                        service:(NSString *)service
                            tag:(IHFunctionTag)tag
                        success:(void (^)(id))success
                        failure:(void (^)(id))failure{
    
     AFHTTPSessionManager *sessionManager = [SessionManager shareManager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString * serviceStr =[NSString stringWithFormat:@"%@%@", serStrURL,service];
    [sessionManager POST:serviceStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JSONDecoder *jd=[[JSONDecoder alloc] init];
            
            NSDictionary *ret = [jd objectWithData: responseObject];
            NSInteger errorNo=[[ret objectForKey:@"code"]integerValue];
            if(errorNo!=0){
                [IHUtility removeWaitingView];
                [WHToast showMessage:[ret objectForKey:@"msg"] duration:1 finishHandler:^{
                }];
                failure(ret);
            }else
            {
                NSDictionary *dic2=[self parseResult:ret tag:nil];
                success(dic2);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary *userInfo=error.userInfo;
        [WHToast showMessage:[userInfo objectForKey:@"NSLocalizedDescription"] duration:1 finishHandler:^{
        }];
        failure(error);
    }];
}
-(void)httpRequestWithParameter:(NSDictionary *)dic method:(NSString *)method success:(void (^)(id))success failure:(void (^)(id))failure{
    
   AFHTTPSessionManager *sessionManager = [SessionManager shareManager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString * serviceStr =[NSString stringWithFormat:@"%@%@", serStrURL,method];
    [sessionManager POST:serviceStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JSONDecoder *jd=[[JSONDecoder alloc] init];
            NSLog(@"%@",[jd objectWithData: responseObject]);
            NSDictionary *ret = [jd objectWithData: responseObject];
              NSInteger errorNo=[[ret objectForKey:@"code"]integerValue];
            if(errorNo!=0){
                [IHUtility removeWaitingView];
                [WHToast showMessage:[ret objectForKey:@"msg"] duration:1 finishHandler:^{
                }];
                failure(ret);
//                if(errorNo==2){
//                    NSLog(@"走几次");
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"notEnough" object:nil];
//                }
            }else
            {
                NSDictionary *dic2=[self parseResult:ret tag:nil];
                success(dic2);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary *userInfo=error.userInfo;
        [WHToast showMessage:[userInfo objectForKey:@"NSLocalizedDescription"] duration:1 finishHandler:^{
        }];
        failure(error);
    }];
}
-(void)httpRequestWithParameter:(NSDictionary *)dic method:(NSString *)method success:(void (^)(id))success{
    AFHTTPSessionManager *sessionManager = [SessionManager shareManager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     NSString * serviceStr =[NSString stringWithFormat:@"%@%@", serStrURL,method];
    [sessionManager POST:serviceStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JSONDecoder *jd=[[JSONDecoder alloc] init];
            NSDictionary *ret = [jd objectWithData: responseObject];
            NSInteger errorNo=[[ret objectForKey:@"code"]integerValue];
          
            if (errorNo!=0) {
                [IHUtility removeWaitingView];
                [WHToast showMessage:[ret objectForKey:@"msg"] duration:1 finishHandler:^{
                }];
                return;
            }
            NSDictionary *dic2=[self parseResult:ret tag:IH_Nothing];
            success(dic2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [IHUtility removeWaitingView];
        NSLog(@"%@",error);
        NSDictionary *userInfo=error.userInfo;
        [WHToast showMessage:[userInfo objectForKey:@"NSLocalizedDescription"] duration:1 finishHandler:^{
        }];
    }];
}

-(void)httpRequestDeleteWithParameter:(NSDictionary *)dic method:(NSString *)method success:(void (^)(id))success{
    AFHTTPSessionManager *sessionManager = [SessionManager shareManager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString * serviceStr =[NSString stringWithFormat:@"%@%@", serStrURL,method];
    [sessionManager DELETE:serviceStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            JSONDecoder *jd=[[JSONDecoder alloc] init];
            NSDictionary *ret = [jd objectWithData: responseObject];
            NSInteger errorNo=[[ret objectForKey:@"code"]integerValue];
            if (errorNo!=0) {
                [IHUtility removeWaitingView];
                [WHToast showMessage:[ret objectForKey:@"msg"] duration:1 finishHandler:^{
                }];
                return;
            }
            NSDictionary *dic2=[self parseResult:ret tag:IH_Nothing];
            success(dic2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [IHUtility removeWaitingView];
        NSLog(@"%@",error);
        NSDictionary *userInfo=error.userInfo;
        [WHToast showMessage:[userInfo objectForKey:@"NSLocalizedDescription"] duration:1 finishHandler:^{
        }];
    }];
}

#pragma mark 构建模型
-(NSDictionary *)parseResult:(NSDictionary*)dic tag:(IHFunctionTag)tag{
    return dic;
}

#pragma mark 获取首页数据
-(void)getHomePages:(int)userId
       success:(void (^)(NSDictionary *obj))success
       failure:(void (^)(NSDictionary *obj2))failure{
    NSString *titleStr = [NSString stringWithFormat:@"/film/film?userId=%d",userId];
    [self httpRequestWithParameterWithGet:titleStr success:^(id dic) {
          success(dic);
    }];
}

@end

