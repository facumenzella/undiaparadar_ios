//
//  SelectedTopicsCollectionView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SelectedTopicsCollectionView.h"
#import "TopicsSelectedCell.h"

static TopicsSelectedCell *cell;

@interface SelectedTopicsCollectionViewLayout : UICollectionViewFlowLayout
@end

@implementation SelectedTopicsCollectionView

-(instancetype)init
{
    self = [super initWithFrame:CGRectNull collectionViewLayout:[[SelectedTopicsCollectionViewLayout alloc] init]];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.scrollEnabled = YES;
        self.pagingEnabled = YES;
        self.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    }
    return self;
}

@end

#pragma mark - SelectedTopicsCollectionViewLayout

@implementation SelectedTopicsCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        cell = [[TopicsSelectedCell alloc] init];
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (CGSize)itemSize
{
    CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    return size;
}

- (CGFloat)minimumInteritemSpacing
{
    return 8;
}

- (CGFloat)minimumLineSpacing
{
    return 4;
}
@end

