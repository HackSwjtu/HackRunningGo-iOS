//
//  HSJDropDownMenuView.h
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HSJDropDownMenuRevealDirection) {
    HSJDown = 0,
    HSJUp
};

@class HSJDropDownMenuView;

@protocol HSJDropDownMenuDelegate <NSObject>

- (void)didTapInDropDownMenuBackground: (HSJDropDownMenuView *)dropDownMenu;

@end

@interface HSJDropDownMenuView : UIView

@property (nonatomic, weak) id<HSJDropDownMenuDelegate> delegate;
- (void)show;
- (void)close;
@end
