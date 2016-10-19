//
//  HSJDropDownMenuViewCell.m
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/19.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "HSJDropDownMenuViewCell.h"

@interface HSJDropDownMenuViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *isSelectedImage;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@end

@implementation HSJDropDownMenuViewCell

- (void)awakeFromNib {
    self.isSelectedImage.hidden = NO;
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)changeState: (NSString *)pos select:(BOOL)sel {
    [self updatePositionName:pos];
    [self updateSelected:sel];
}

- (void)updatePositionName: (NSString *)position {
    self.positionLabel.text = position;
}

- (void)updateSelected: (BOOL)isSelected {
    self.isSelectedImage.hidden = isSelected;
}

@end
