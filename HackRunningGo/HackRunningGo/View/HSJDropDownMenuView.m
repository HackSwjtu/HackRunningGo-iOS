//
//  HSJDropDownMenuView.m
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "HSJDropDownMenuView.h"
#import "HSJDropDownMenuViewCell.h"

static NSString *CellIdentifier = @"HSJDropDownMenuViewCell";

@interface HSJDropDownMenuView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) HSJDropDownMenuRevealDirection direction;
@property (nonatomic, strong) NSArray<NSDictionary *> *data;

@end

@implementation HSJDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        self.menuView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:self.menuView];
        
        [self.menuView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
        self.menuView.delegate = self;
        self.menuView.dataSource = self;
        self.hidden = YES;
        [self addSubview:self.contentView];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TestPoints" ofType:@"plist"];
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        self.data = data;
        [self.menuView reloadData];
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
    return self.data.count;
}

- (HSJDropDownMenuViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSJDropDownMenuViewCell *cell = (HSJDropDownMenuViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HSJDropDownMenuViewCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
    }
//    NSLog(@"%@", self.data[indexPath.row]);
    NSDictionary *cellData = (NSDictionary *)self.data[indexPath.row];
    NSString *name = [cellData objectForKey:@"name"];
    BOOL show = [cellData objectForKey:@"state"];
    [cell changeState:name  select:show];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.menuView sizeToFit];
}

#pragma mark - Setter


@end
