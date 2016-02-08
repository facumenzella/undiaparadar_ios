//
//  UILabel+EstimatedHeight.m
//  ClaroViajes
//
//  Created by Facundo Menzella on 11/12/15.
//  Copyright (c) 2015 Monits. All rights reserved.
//

#import "UILabel+EstimatedHeight.h"
#import <math.h>

@implementation UILabel (EstimatedHeight)

- (CGFloat)numberOfLinesForWidth:(CGFloat)width
{
    CGFloat height = [self heightForText:self.text withWidth:width usingFont:self.font];
    CGFloat unitHeight = [self heightForText:@"A" withWidth:width usingFont:self.font];
    
    return (CGFloat)ceil(height / unitHeight);
}

- (CGFloat)heightForText:(NSString*)str withWidth:(CGFloat)width usingFont:(UIFont *)font
{
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize labelSize = CGSizeMake(width, FLT_MAX);
    CGRect r = [str boundingRectWithSize:labelSize
                                 options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{NSFontAttributeName: font}
                                 context:context];
    return r.size.height;
}

@end
