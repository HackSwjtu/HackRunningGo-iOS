//
//  HSJPointModel.h
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/19.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSJPointModel : NSObject

@property (nonatomic, assign) BOOL state;
@property (nonatomic, assign) double x, y;
@property (nonatomic, copy) NSString *name;

@end
