//
//  SelectedTopicsViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/7/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "SelectedTopicsViewController.h"
#import "SelectedTopicsCollectionView.h"
#import "TopicsSelectedCell.h"

static NSString *const IDENTIFIER = @"SelectedCell";

@interface SelectedTopicsViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SelectedTopicsViewController

-(void)loadView
{
    self.collectionView = [[SelectedTopicsCollectionView alloc] init];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.view = self.collectionView;
}

- (void)viewDidLoad
{
    [self.collectionView registerClass:[TopicsSelectedCell class] forCellWithReuseIdentifier:IDENTIFIER];
}

- (void)setSelectedTopics:(NSMutableArray *)selectedTopics
{
    _selectedTopics = selectedTopics;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [indexPath row];
    [self.selectedTopics removeObject:[self.selectedTopics objectAtIndex:index]];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.selectedTopics count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicsSelectedCell *cell  =
    (TopicsSelectedCell*)[self.collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER
                                                                        forIndexPath:indexPath];
    Topic *t = self.selectedTopics[[indexPath row]];
    [cell populateWithTopic:t];
    
    return cell;
}

@end
