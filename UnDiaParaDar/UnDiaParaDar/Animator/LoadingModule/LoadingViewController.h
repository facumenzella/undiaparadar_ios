//
//  LoadingViewController.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoadingBlock)(UIViewController *loading);

@interface LoadingViewController : UIViewController

- (instancetype)initWithLoadingBlock:(LoadingBlock)loadingBlock;

@end
