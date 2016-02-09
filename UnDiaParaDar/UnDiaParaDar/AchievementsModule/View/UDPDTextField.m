//
//  UDPDTextField.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 2/9/16.
//  Copyright © 2016 ITBA. All rights reserved.
//

#import "UDPDTextField.h"

@interface UDPDTextField ()

@property (nonatomic) CGColorRef baseColor;

@end

@implementation UDPDTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self styleSubviews];
    }
    return self;
}

- (void)buildSubviews
{
    
}

- (void)styleSubviews
{
    self.placeholder = @"Código";
}

- (void)invalidInput
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)setError:(BOOL)error
{
    if (error) {
        self.baseColor = self.layer.borderColor;
        self.layer.borderColor = [[UIColor redColor] CGColor];
        [self invalidInput];
    } else {
        self.layer.borderColor = self.baseColor;
    }
}

@end
