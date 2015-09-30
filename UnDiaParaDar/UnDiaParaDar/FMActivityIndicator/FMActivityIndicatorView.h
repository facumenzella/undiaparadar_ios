//
//  FMActivityIndicatorView.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMActivityIndicatorView : UIActivityIndicatorView

@property (nonatomic, strong) UIImage * image;

-(id)initWithImage:(UIImage*)image;

@end
