//
//  TopicsCollectionView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsCollectionView.h"
#import "TopicsCollectionViewCell.h"

static TopicsCollectionViewCell *cell;
static CGFloat MINIMUM_LINE_SPACING = 0;
static CGFloat MINIMUM_INTERITEM_SPACING = 0;

@interface TopicsCollectionViewLayout : UICollectionViewFlowLayout
@end

@implementation TopicsCollectionView

- (instancetype)init
{
    self = [super initWithFrame:CGRectNull collectionViewLayout:[[TopicsCollectionViewLayout alloc] init]];
    if (self) {
        UIImageView *background = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Splash"]];
        [self setBackgroundView:background];
        self.contentInset = UIEdgeInsetsMake(8, 12, 8, 12);
        self.allowsMultipleSelection = YES;
    }
    return self;
}

@end

#pragma mark - TopicsCollectionViewLayout

@implementation TopicsCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildCell];
    }
    return self;
}

- (CGSize)itemSize
{
    return [cell systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
}

- (CGFloat)minimumInteritemSpacing
{
    return MINIMUM_INTERITEM_SPACING;
}

- (CGFloat)minimumLineSpacing
{
    return MINIMUM_LINE_SPACING;
}

- (void)buildCell
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [[TopicsCollectionViewCell alloc] init];
    });
}

@end


