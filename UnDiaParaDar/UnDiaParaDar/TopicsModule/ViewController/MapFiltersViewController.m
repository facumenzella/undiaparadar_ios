//
//  MapFiltersViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/1/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "MapFiltersViewController.h"
#import "MapFiltersView.h"
#import "TopicsFilterViewCell.h"
#import "TopicCellPresenter.h"

#import "Routing.h"
#import "TopicService.h"

static NSString *const IDENTIFIER = @"TopicsFilterViewCell";

@interface MapFiltersViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MapFiltersViewDelegate>

@property (nonatomic, strong) MapFiltersView *mapFiltersView;
@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;

@property (nonatomic, strong) NSMutableArray *topicPresenters;

@end

@implementation MapFiltersViewController

- (instancetype)initWithRouting:(id<Routing>)routing withTopicsService:(TopicService*)topicService
{
    self = [super init];
    if (self) {
        self.topicService = topicService;
        self.routing = routing;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)loadView
{
    self.mapFiltersView = [[MapFiltersView alloc] init];
    self.mapFiltersView.collectionView.dataSource = self;
    self.mapFiltersView.delegate = self;
    self.view = self.mapFiltersView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topicPresenters = [[NSMutableArray alloc] init];
    NSArray *topics = [self.topicService topics];
    for (Topic *t in topics) {
        [self.topicPresenters addObject:[[TopicCellPresenter alloc] initWithTopic:t]];
    }
    [self.mapFiltersView.collectionView registerClass:[TopicsFilterViewCell class]
                           forCellWithReuseIdentifier:IDENTIFIER];
    [self.mapFiltersView.collectionView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mapFiltersView modalStyle];
}

#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.topicPresenters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicsFilterViewCell *cell  =
    (TopicsFilterViewCell*)[self.mapFiltersView.collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER
                                                                                         forIndexPath:indexPath];
    TopicCellPresenter *t = self.topicPresenters[[indexPath row]];
    [cell populateCellWithTopic:t];
    
    return cell;
}

#pragma mark - MapFiltersDelegate

- (void)didTapCancel
{
    [self.routing dismissViewController:self];
}

- (void)didTapAccept
{
    // TODO
    [self.routing dismissViewController:self];
}

@end
