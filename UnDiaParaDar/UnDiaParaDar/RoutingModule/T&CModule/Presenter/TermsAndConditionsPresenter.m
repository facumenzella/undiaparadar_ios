//
//  TermsAndConditionsPresenter.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TermsAndConditionsPresenter.h"

@implementation TermsAndConditionsPresenter

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
