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
    return [NSString stringWithFormat:@"Basic %@", self.base64Encode];
}

- (NSString *)accept {
    return @"*/*";
}

- (NSString *)proxyConnection {
    return @"keep-alive";
}

- (NSString *)osType {
    return @"1";
}

- (NSString *)appVersion {
    // TODO:
    return @"1.2.0";
}

- (NSString *)acceptEncoding {
    return @"gzip, deflate";
}

- (NSString *)acceptLanguage {
    return @"zh-Hans-CN;q=1";
}

- (NSString *)contentType {
    return @"application/x-www-form-urlencoded";
}

- (NSString *)deviveld {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)customDeviceId {
    return [NSString stringWithFormat:@"%@_iOS_sportsWorld_campus", self.deviveld];
}

- (NSString *)contentLength {
    return @"0";
}

- (NSString *)userAgent {
    // TODO:
    return @"SWCampus/1.2.0 (iPhone; iOS 9.3.4; Scale/3.00)";
}

- (NSString *)connection {
    return @"keep-alive";
}

@end
