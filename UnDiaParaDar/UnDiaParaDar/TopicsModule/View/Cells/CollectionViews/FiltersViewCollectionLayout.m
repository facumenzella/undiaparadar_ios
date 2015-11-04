//
//  FiltersViewCollectionLayout.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "FiltersViewCollectionLayout.h"
#import "TopicsFilterViewCell.h"

static CGFloat const kMinimumLineSpacing = 8;
static CGFloat const kMinimumInteritemSpacing = 16;
static TopicsFilterViewCell *cell;

@implementation FiltersViewCollectionLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
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
    return kMinimumInteritemSpacing;
}

- (CGFloat)minimumLineSpacing
{
    return kMinimumLineSpacing;
}

- (void)buildCell
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [[TopicsFilterViewCell alloc] init];
    });
}

@end
