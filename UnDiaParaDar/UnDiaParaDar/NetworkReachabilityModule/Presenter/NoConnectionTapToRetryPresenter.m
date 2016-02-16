//
//  NoConnectionTapToRetryPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/15/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "NoConnectionTapToRetryPresenter.h"

@interface NoConnectionTapToRetryPresenter ()

@property (nonatomic, strong, readwrite) NSString *tapTitle;

@end

@implementation NoConnectionTapToRetryPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tapTitle = NSLocalizedString(@"NO_CONNECTION", @"No posee conexion a internet");
    }
    return self;
}

@end
