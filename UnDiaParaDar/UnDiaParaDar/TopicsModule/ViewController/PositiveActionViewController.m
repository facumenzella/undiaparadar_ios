//
//  PositiveActionViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionViewController.h"
#import "PositiveActionView.h"
#import "PositiveAction.h"
#import "Topic.h"

#import "FacebookShareScout.h"
#import "Routing.h"
#import "TopicService.h"

@interface PositiveActionViewController ()<PositiveActionViewDelegate, FBSDKSharingDelegate>

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) TopicService *topicService;

@property (nonatomic, strong) PositiveActionView *positiveActionView;
@property (nonatomic, strong) PositiveAction *positiveAction;

@property (nonatomic, strong) FacebookShareScout *scout;

@end

@implementation PositiveActionViewController

- (instancetype)initWithPositiveAction:(PositiveAction*)positiveAction
                           withRouting:(id<Routing>)routing
                      withTopicService:(TopicService*)topicService
{
    self = [super init];
    if (self) {
        self.routing = routing;
        self.topicService = topicService;
        self.positiveAction = positiveAction;
    }
    return self;
}

- (void)loadView
{
    self.positiveActionView = [[PositiveActionView alloc] init];
    self.positiveActionView.delegate = self;
    self.view = self.positiveActionView;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"POSITIVE_ACTION", @"Acción positiva");
    
    Topic *topic = [self.topicService topicById:self.positiveAction.topicID];
    [self.positiveActionView populateWithPositiveAction:self.positiveAction withTopicImage:topic.selectedImg];
}

#pragma mark - PositiveActionViewDelegate

- (void)share
{
    self.scout = [[FacebookShareScout alloc] initWithLink:self.positiveAction.externalURL
                                                 withTitle:self.positiveAction.title];
    [self.scout shareWithViewController:self];
}

- (void)pledge
{
    [self.routing showPledgeViewControllerForPositiveAction:self.positiveAction withPresenter:self];
}

#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    self.scout = nil;
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    self.scout = nil;
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    self.scout = nil;
}

@end
