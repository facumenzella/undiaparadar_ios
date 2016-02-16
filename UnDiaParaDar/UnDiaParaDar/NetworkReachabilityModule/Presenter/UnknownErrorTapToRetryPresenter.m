//
//  UnknownErrorTapToRetry.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/15/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "UnknownErrorTapToRetryPresenter.h"

@interface UnknownErrorTapToRetryPresenter ()

@property (nonatomic, strong, readwrite) NSString *tapTitle;

@end

@implementation UnknownErrorTapToRetryPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tapTitle = NSLocalizedString(@"UNKNOWN_ERROR", @"Ha ocurrido un error inesperado");
    }
    return self;
}

@end
