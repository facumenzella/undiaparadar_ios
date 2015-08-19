//
//  TopicsCollectionViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsCollectionViewController.h"
#import "TopicCollectionViewCell.h"
#import "TopicsCollectionViewLayout.h"

#import "TopicService.h"
#import "Routing.h"

@interface TopicsCollectionViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;
@property (nonatomic, strong) NSMutableArray *topics;

@end

@implementation TopicsCollectionViewController

static const NSInteger SECTIONS = 1;
static NSString * const reuseIdentifier = @"TopicCollectionViewCell";

#pragma mark - TopicsCollectionViewController

- (instancetype)initWithRouting:(id<Routing>)routing withTopicsService:(TopicService*)topicService
{
    if (self = [super initWithCollectionViewLayout:[[TopicsCollectionViewLayout alloc] init]]) {
        self.routing = routing;
        self.topicService = topicService;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTopics];
    // TODO change this, put it inside a view
    self.collectionView.contentInset = UIEdgeInsetsMake(8, 32, 8, 32);
    [self.collectionView registerClass:[TopicCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
}

- (void)loadTopics
{
    self.topics = [self.topicService topics];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return SECTIONS;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.topics count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    if (!cell) {
        cell = [[TopicCollectionViewCell alloc] init];
    }
    Topic *t = [self.topics objectAtIndex: [indexPath row]];
    [cell populateCellWithTopic:t];
    return cell;
}

@end
