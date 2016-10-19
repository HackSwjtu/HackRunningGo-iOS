//
//  HSJDropDownMenuViewCell.h
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/19.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSJDropDownMenuViewCell : UITableViewCell

- (void)changeState: (NSString *)pos select:(BOOL)sel;
- (void)updatePositionName: (NSString *)position;

@end
