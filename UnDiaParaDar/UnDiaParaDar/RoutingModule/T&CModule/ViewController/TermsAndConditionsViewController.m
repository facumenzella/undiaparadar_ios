//
//  TermsAndConditionsViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "TermsAndConditionsView.h"
#import "TermsAndConditionsPresenter.h"

@interface TermsAndConditionsViewController ()

@property (nonatomic, strong) NSString *pathToTermsAndConditions;
@property (nonatomic, strong) TermsAndConditionsView *termsAndConditionsView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TermsAndConditionsViewController

- (instancetype)initWithTYCPath:(NSString*)path
{
    self = [super init];
    if (self) {
        self.pathToTermsAndConditions = path;
    }
    return self;
}

- (void)loadView
{
    TermsAndConditionsPresenter *presenter = [[TermsAndConditionsPresenter alloc]
                                              initWithPathToHTML:self.pathToTermsAndConditions];
    self.termsAndConditionsView = [[TermsAndConditionsView alloc] initWithTermsAndConditions:presenter];
    
    self.view = self.termsAndConditionsView;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"TERMSANDCONDITIONS_SECTION", @"Términos y condiciones");
}

@end
