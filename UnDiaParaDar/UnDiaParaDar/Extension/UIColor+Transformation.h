//
//  UIColor+Transformation.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 10/15/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Transformation)

- (UIColor*)lightenWithTintFactor:(CGFloat)factor;
- (UIColor*)shadeWithShadeFactor:(CGFloat)factor;

@end
