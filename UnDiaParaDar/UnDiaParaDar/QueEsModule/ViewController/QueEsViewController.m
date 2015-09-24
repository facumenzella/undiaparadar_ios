//
//  QueEsViewController.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/24/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "QueEsViewController.h"
#import "QueEsPresenter.h"
#import "QueEsView.h"

@interface QueEsViewController ()

@property (nonatomic, strong) NSString *pathToQueEsAndConditions;
@property (nonatomic, strong) QueEsView *queEsView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QueEsViewController

- (instancetype)initWithQueEsPath:(NSString*)path
{
    self = [super init];
    if (self) {
        self.pathToQueEsAndConditions = path;
    }
    return self;
}

- (void)loadView
{
    QueEsPresenter *presenter = [[QueEsPresenter alloc]
                                 initWithPathToHTML:self.pathToQueEsAndConditions];
    self.queEsView = [[QueEsView alloc] initWithQueEs:presenter];
    self.view = self.queEsView;
}

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"QUEES_SECTION", @"Qué es UDPD?");
}

@end