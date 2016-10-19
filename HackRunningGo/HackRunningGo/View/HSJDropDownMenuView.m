//
//  HSJDropDownMenuView.m
//  HackRunningGo
//
//  Created by 段昊宇 on 16/10/18.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "HSJDropDownMenuView.h"
#import "HSJDropDownMenuViewCell.h"
#import "HSJPointModel.h"

static NSString *CellIdentifier = @"HSJDropDownMenuViewCell";

@interface HSJDropDownMenuView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) HSJDropDownMenuRevealDirection direction;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *data;
@property (nonatomic, copy) NSArray<HSJPointModel *> *tableData;

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
        self.menuView.backgroundColor = [UIColor colorWithRed:105 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:1];
        self.hidden = YES;
        [self addSubview:self.contentView];
        
        [self clearData];
    }
    return self;
}

- (void)clearData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TestPoints" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray<HSJPointModel *> *newTableData = @[].mutableCopy;
    
    for (NSDictionary *one in data) {
        HSJPointModel *o = [[HSJPointModel alloc] init];
        o.state = [[one objectForKey:@"state"] boolValue];
        o.name = (NSString *)[one objectForKey:@"name"];
        o.x = [[one objectForKey:@"x"] doubleValue];
        o.y = [[one objectForKey:@"y"] doubleValue];
        [newTableData addObject:o];
    }
    
    self.tableData = newTableData;
    
    [self.menuView reloadData];
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

- (void)close: (dropDownCallBackBlock)callBack {
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
    callBack(self.tableData);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (HSJDropDownMenuViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSJDropDownMenuViewCell *cell = (HSJDropDownMenuViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HSJDropDownMenuViewCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
    }

    HSJPointModel *data = self.tableData[indexPath.row];
    [cell changeState:data.name select:data.state];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HSJPointModel *data = self.tableData[indexPath.row];
    if (data.state) {
        data.state = NO;
    } else {
        data.state = YES;
    }
    [self.menuView reloadData];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.menuView sizeToFit];
}

#pragma mark - Setter


@end
