//
//  TopicsCollectionViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsCollectionViewController.h"
#import "TopicService.h"
#import "Routing.h"

@interface TopicsCollectionViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;

@property (nonatomic, strong) NSMutableArray *topics;

@end

@implementation TopicsCollectionViewController

static const NSInteger SECTIONS = 1;
static NSString * const reuseIdentifier = @"TopicCell";

#pragma mark - TopicsCollectionViewController

- (instancetype)initWithRouting:(id<Routing>)routing withTopicsService:(TopicService*)topicService
{
    if (self = [super init]) {
        self.routing = routing;
        self.topicService = topicService;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTopics];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

@end
