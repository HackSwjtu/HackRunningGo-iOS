//
//  HSJDropDownMenuView.m
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "HSJDropDownMenuView.h"

static NSString *CellIdentifier = @"HSJDropDownMenuViewCell";

@interface HSJDropDownMenuView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) HSJDropDownMenuRevealDirection direction;

@end

@implementation HSJDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        self.menuView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:self.menuView];
        
        [self.menuView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        self.menuView.delegate = self;
        self.menuView.dataSource = self;
        self.hidden = YES;
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)show {
    if (!self.isHidden) {
        return ;
    }
    if (self.direction == HSJDown) {
        self.transform = CGAffineTransformTranslate(self.transform, 0, -self.frame.size.height);
        self.hidden = NO;
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.transform = CGAffineTransformIdentity;
                         }];
    }
}

- (void)close {
    if (self.isHidden) {
        return ;
    }
    if (self.direction == HSJDown) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             self.hidden = YES;
                         }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.menuView sizeToFit];
}

#pragma mark - Setter


@end
