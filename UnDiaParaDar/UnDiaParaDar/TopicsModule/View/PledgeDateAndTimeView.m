//
//  PledgeDateAndTimeView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/7/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "PledgeDateAndTimeView.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

@interface PledgeDateAndTimeView ()

@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation PledgeDateAndTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubviews];
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    [self buildHeader];
    [self buildTableView];
}

- (void)buildHeader
{
    self.header = [[UILabel alloc] initForAutoLayout];
    self.header.text = @"Elige la hora y el dia en el cual realizaras la accion positiva";
    [self addSubview:self.header];
    [self.header autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:24];
    [self.header autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    [self.header autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
}

- (void)buildTableView
{
    self.tableView = [[UITableView alloc] initForAutoLayout];
    [self addSubview:self.tableView];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.header withOffset:8];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
    // In order to remove empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)styleSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    [self styleHeader];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
}

- (void)styleHeader
{
    self.header.backgroundColor = [UIColor clearColor];
    self.header.numberOfLines = 4;
    self.header.textAlignment = NSTextAlignmentCenter;
    self.header.font = [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                      withSize:BeautyCenterTypographySizeB];
}

@end
