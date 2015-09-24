//
//  QueEsPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "QueEsPresenter.h"

@implementation QueEsPresenter

- (instancetype)initWithPathToHTML:(NSString*)pathToHTML
{
    self = [super init];
    if (self) {
        [self loadHTML:pathToHTML];
    }
    return self;
}

- (void)loadHTML:(NSString*)html
{
    NSString *file = [[NSBundle mainBundle] pathForResource:html ofType:@"html"];
    self.htmlTermsAndConditions = [NSString stringWithContentsOfFile:file
                                                            encoding:NSUTF8StringEncoding
                                                               error:nil];
}

@end
