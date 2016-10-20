//
//  HSJUserDataDefault.m
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "HSJUserDataDefault.h"
#import "NSString+Base64.h"
#import <UIKit/UIKit.h>

@implementation HSJUserDataDefault

- (NSString *)userName {
    if (!_userName) {
        return @"";
    }
    else {
        return _userName;
    }
}

- (NSString *)password {
    if (!_password) {
        return @"";
    } else {
        return _password;
    }
}

- (NSString *)base64Encode {
    _base64Encode = [NSString stringWithFormat:@"%@:%@", self.userName, self.password];
    return [_base64Encode base64EncodedString];
}

- (NSString *)authorization {
    _authorization = [NSString stringWithFormat:@"Basic %@", self.base64Encode];
    return _authorization;
}

- (NSString *)accept {
    _accept = @"*/*";
    return _accept;
}

- (NSString *)proxyConnection {
    _proxyConnection = @"keep-alive";
    return _proxyConnection;
}

- (NSString *)osType {
    _osType = @"1";
    return _osType;
}

- (NSString *)appVersion {
    // TODO:
    _appVersion = @"1.2.0";
    return @"1.2.0";
}

- (NSString *)acceptEncoding {
    _acceptEncoding = @"gzip, deflate";
    return @"gzip, deflate";
}

- (NSString *)acceptLanguage {
    _acceptLanguage = @"zh-Hans-CN;q=1";
    return @"zh-Hans-CN;q=1";
}

- (NSString *)contentType {
    _contentType = @"application/x-www-form-urlencoded";
    return @"application/x-www-form-urlencoded";
}

- (NSString *)deviveld {
    _deviveld = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)customDeviceId {
    _customDeviceId = [NSString stringWithFormat:@"%@_iOS_sportsWorld_campus", self.deviveld];
    return [NSString stringWithFormat:@"%@_iOS_sportsWorld_campus", self.deviveld];
}

- (NSString *)contentLength {
    _contentLength = @"0";
    return @"0";
}

- (NSString *)userAgent {
    // TODO:
    _userAgent = @"SWCampus/1.2.0 (iPhone; iOS 9.3.4; Scale/3.00)";
    return @"SWCampus/1.2.0 (iPhone; iOS 9.3.4; Scale/3.00)";
}

- (NSString *)connection {
    _connection = @"keep-alive";
    return @"keep-alive";
}

- (NSString *)source {
    _source = @"000049";
    return _source;
}

@end
