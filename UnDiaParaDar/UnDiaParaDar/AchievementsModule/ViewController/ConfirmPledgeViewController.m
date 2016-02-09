//
//  ConfirmPledgeViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/9/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "ConfirmPledgeViewController.h"
#import "ConfirmPledgePopupView.h"
#import "Routing.h"
#import "Achievement.h"
#import "AchievementService.h"

@interface ConfirmPledgeViewController () <ConfirmPledgePopupViewDelegate>

@property (nonatomic, strong) ConfirmPledgePopupView *popupView;
@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) AchievementService *service;
@property (nonatomic, strong) Achievement *achieve;

@end


@implementation ConfirmPledgeViewController

- (instancetype)initWithAchievementService:(AchievementService*)service
                               withRouting:(id<Routing>)routing
                           withAchievement:(Achievement*)achieve
{
    self = [super init];
    if (self){
        self.routing = routing;
        self.service = service;
        self.achieve = achieve;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)loadView
{    
    self.popupView = [[ConfirmPledgePopupView alloc] init];
    self.popupView.delegate = self;
    self.view = self.popupView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.popupView modalStyle];
}

#pragma mark - ConfirmPledgePopupViewDelegate

// I do not like this, but whatever
// it's just one case

- (void)confirmWithCode:(NSString *)code
{
    if ([code isEqualToString:self.achieve.code]) {
        NSLog(@"match");
        [self.service confirmAchievement:self.achieve];
        [self.routing dismissViewController:self withCompletion:nil];
    } else {
        NSLog(@"no match");
        
    }
}

- (void)dismiss
{
    [self.routing dismissViewController:self withCompletion:nil];
}

@end
