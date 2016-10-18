//
//  NSString+Base64.h
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

@end
