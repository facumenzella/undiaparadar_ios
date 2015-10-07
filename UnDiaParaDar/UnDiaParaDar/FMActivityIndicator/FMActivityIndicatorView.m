//
//  FMActivityIndicatorView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "FMActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>
#import <PureLayout/PureLayout.h>

static CGFloat kDURATION = 1.2f;

@interface FMActivityIndicatorView ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) CABasicAnimation * animation;

@end

@implementation FMActivityIndicatorView

- (instancetype)init
{
    return [self initWithImage:nil];
}

-(id)initWithImage:(UIImage*)image
{
    self = [super init];
    if(self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.image = image;
        [self buildAnimation];
    }
    return self;
}

- (void)buildAnimation
{
    self.animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.animation.fromValue = [NSNumber numberWithFloat:0.0f];
    self.animation.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    self.animation.toValue = [NSNumber numberWithFloat: -2*M_PI];
    self.animation.duration = kDURATION;
    self.animation.repeatCount = HUGE_VAL;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:self.imageView];
    [self.imageView setImage: _image];
    [self.imageView autoCenterInSuperview];
}

-(void)startAnimating
{
    self.imageView.hidden = NO;
    [self.imageView.layer addAnimation:self.animation forKey:@"animation"];
}

-(void)stopAnimating
{
    self.imageView.hidden = YES;
    [self.imageView.layer removeAllAnimations];
}


@end
