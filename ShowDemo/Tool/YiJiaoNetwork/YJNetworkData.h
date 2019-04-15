//
//  YJNetworkData.h
//  YJJSApp
//
//  Created by DT on 2018/3/21.
//  Copyright © 2018年 dt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNetworkConst.h"
#define network         [YJNetworkData shareInstance]

@interface YJNetworkData : NSObject
-(NSDictionary *)parseResult:(NSDictionary*)dic tag:(IHFunctionTag)tag;


-(void)httpRequestTagWithServer:(NSDictionary *)dic
                        service:(NSString *)service
                            tag:(IHFunctionTag)tag
                        success:(void (^)(id))success
                        failure:(void (^)(id))failure;
//根据tag 来封装数据
-(void)httpRequestTagWithParameter:(NSDictionary *)dic
                            method:(NSString *)method
                               tag:(IHFunctionTag)tag
                           success:(void (^)(id))success
                           failure:(void (^)(id))failure;
-(void)httpRequestWithParameter:(NSDictionary *)dic
                         method:(NSString *)method
                        success:(void (^)(id))success
                        failure:(void (^)(id))failure;
-(void)httpRequestWithParameter:(NSDictionary *)dic
                         method:(NSString *)method
                        success:(void (^)(id))success;

-(void)httpRequestWithParameterWithGet:(NSString *)method success:(void (^)(id))success;
+(YJNetworkData *)shareInstance;
@property(nonatomic,assign) int tag;
#pragma mark 获取首页数据
#pragma mark 获取首页数据
-(void)getHomePages:(int)userId
            success:(void (^)(NSDictionary *obj))success
            failure:(void (^)(NSDictionary *obj2))failure;

@end

