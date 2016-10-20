//
//  HSJNetwork.h
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/20.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^callBackBlock)(NSDictionary *dic);

@class HSJUserDataDefault;
@interface HSJNetwork : NSObject

+ (void)loginByName:(HSJUserDataDefault *)user handler: (callBackBlock)callback;

@end
