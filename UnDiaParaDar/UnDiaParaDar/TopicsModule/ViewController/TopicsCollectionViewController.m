//
//  TopicsCollectionViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 8/14/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TopicsCollectionViewController.h"
#import "TopicsCollectionViewCell.h"
#import "TopicsCollectionViewLayout.h"

#import "TopicService.h"
#import "TopicCellPresenter.h"
#import "Routing.h"

@interface TopicsCollectionViewController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSMutableArray *presenters;
@property (nonatomic, strong) NSMutableArray *selectedTopics;

@property (nonatomic, copy) SelectedTopicsCallback callback;

@end

@implementation TopicsCollectionViewController

static const NSInteger SECTIONS = 1;
static NSString * const reuseIdentifier = @"TopicCollectionViewCell";

#pragma mark - TopicsCollectionViewController

- (instancetype)initWithRouting:(id<Routing>)routing
              withTopicsService:(TopicService*)topicService
    withTopicsSelectionDelegate:(id<TopicsSelectionDelegate>)selectionDelegate
{
    TopicsCollectionViewLayout *layout = [[TopicsCollectionViewLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.routing = routing;
        self.topicService = topicService;
        self.selectionDelegate = selectionDelegate;
        self.callback = nil;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Encuentra que hacer";
    
    [self loadTopics];
    // TODO change this, put it inside a view
    UIImageView *background = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Splash"]];
    [self.collectionView setBackgroundView:background];
    self.collectionView.contentInset = UIEdgeInsetsMake(8, 24, 8, 24);
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[TopicsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
    
    [self.selectionDelegate viewController:self
                           didSelectTopics:self.selectedTopics
                              withCallback:self.callback];
}

- (void)loadTopics
{
    self.topics = [self.topicService topics];
    self.presenters = [[NSMutableArray alloc] init];
    self.selectedTopics = [[NSMutableArray alloc] init];
    for (Topic *t in self.topics) {
        TopicCellPresenter *p = [[TopicCellPresenter alloc] initWithTopic:t];
        [self.presenters addObject:p];
    }
}


#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return SECTIONS;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.topics count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopicsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    if (!cell) {
        cell = [[TopicsCollectionViewCell alloc] init];
    }
    TopicCellPresenter *t = [self.presenters objectAtIndex: [indexPath row]];
    [cell populateCellWithTopic:t];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    
    TopicCellPresenter *t = [self.presenters objectAtIndex: [indexPath row]];
    t.selected = !t.selected;
    
    [cell populateCellWithTopic:t]; 
    
    if (t.selected) {
        [self.selectedTopics addObject:t];
    } else {
        [self.selectedTopics removeObject:t];
    }
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self.selectionDelegate viewController:self
                           didSelectTopics:self.selectedTopics
                              withCallback:self.callback];
}

#pragma mark - RightNextButtonProtocol

- (void)next
{
    [self.routing showPositiveActionsWithMapViewControllerWithPresenter:self withSelectedTopics: self.selectedTopics];
}

@end
