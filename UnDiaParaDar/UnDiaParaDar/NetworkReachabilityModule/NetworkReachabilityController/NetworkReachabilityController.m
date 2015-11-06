//
//  NetworkReachabilityController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 11/5/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "NetworkReachabilityController.h"
#import "GCNetworkReachability.h"
#import "Routing.h"

@interface NetworkReachabilityController ()

@property (nonatomic, strong) id<Routing> routing;
@property (nonatomic, strong) GCNetworkReachability *reachability;

@end

@implementation NetworkReachabilityController

- (instancetype)initWithRouting:(id<Routing>)routing
{
    self = [super init];
    if (self) {
        self.routing = routing;
    }
    return self;
}

- (void)setup
{
    self.reachability = [GCNetworkReachability reachabilityForInternetConnection];
    [self.reachability startMonitoringNetworkReachabilityWithHandler:^(GCNetworkReachabilityStatus status) {
        // this block is called on the main thread
        switch (status) {
            case GCNetworkReachabilityStatusNotReachable:
                [self.routing showNetworkReachability];
                break;
            case GCNetworkReachabilityStatusWiFi:
            case GCNetworkReachabilityStatusWWAN:
            default:
                break;
        }
    }];
}

@end
