//
//  UIColor+Transformation.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/15/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "UIColor+Transformation.h"

@implementation UIColor (Transformation)

- (UIColor*)lightenWithTintFactor:(CGFloat)factor
{
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    const CGFloat newRed = red + (1 - red) * factor;
    const CGFloat newGreen = green + (1 - green) * factor;
    const CGFloat newBlue = blue + (1 - blue) * factor;
    
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:alpha];
}

- (UIColor*)shadeWithShadeFactor:(CGFloat)factor
{
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    const CGFloat newRed = red * (1 - factor);
    const CGFloat newGreen = green * (1 - factor);
    const CGFloat newBlue = blue * (1 - factor);
    
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:alpha];
}

@end
