//
//  LoadingModuleAssembly.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/2/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "TyphoonAssembly.h"
#import "LoadingViewController.h"

@interface LoadingModuleAssembly : TyphoonAssembly

- (LoadingViewController*)loadingViewControllerWithLoadingBlock:(LoadingBlock)loadingBlock;

@end
