//
//  HSJNetwork.m
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/20.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "HSJNetwork.h"
#import <AFNetworking.h>
#import "HSJUserDataDefault.h"

@implementation HSJNetwork

+ (void)loginByName:(HSJUserDataDefault *)user handler: (callBackBlock)callback {
    NSURL *baseUrl = [NSURL URLWithString:@"gxapp.iydsj.com"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"gxapp.iydsj.com" forHTTPHeaderField:@"Host"];
    [manager.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:user.authorization forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:user.proxyConnection forHTTPHeaderField:@"Proxy-Connection"];
    [manager.requestSerializer setValue:user.osType forHTTPHeaderField:@"osType"];
    [manager.requestSerializer setValue:user.appVersion forHTTPHeaderField:@"appVersion"];
    [manager.requestSerializer setValue:user.acceptEncoding forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:user.acceptLanguage forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:user.contentType forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:user.deviveld forHTTPHeaderField:@"DeviceId"];
    [manager.requestSerializer setValue:user.customDeviceId forHTTPHeaderField:@"CustomDeviceId"];
    [manager.requestSerializer setValue:user.contentLength forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:user.userAgent forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:user.connection forHTTPHeaderField:@"Connection"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"http://gxapp.iydsj.com/api/v3/login"
       parameters:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@", responseObject);
              NSDictionary *res = (NSDictionary *)responseObject;
              callback(res);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"%@", error);
          }];
}

+ (void)uploadData:(HSJUserDataDefault *)user handler: (callBackBlock)callback {
    NSURL *baseUrl = [NSURL URLWithString:@"gxapp.iydsj.com"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
    [manager.requestSerializer setValue:user.appVersion forHTTPHeaderField:@"appVersion"];
    [manager.requestSerializer setValue:user.customDeviceId forHTTPHeaderField:@"CustomDeviceId"];
    [manager.requestSerializer setValue:user.deviveld forHTTPHeaderField:@"DeviceId"];
    [manager.requestSerializer setValue:user.osType forHTTPHeaderField:@"osType"];
    [manager.requestSerializer setValue:user.source forHTTPHeaderField:@"source"];
    [manager.requestSerializer setValue:user.uid forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:user.authorization forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://gxapp.iydsj.com/api/v2/users/%@/running_records/add", user.uid]
       parameters:nil
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@", responseObject);
              NSDictionary *res = (NSDictionary *)responseObject;
              callback(res);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"%@", error);
          }];
}

@end
