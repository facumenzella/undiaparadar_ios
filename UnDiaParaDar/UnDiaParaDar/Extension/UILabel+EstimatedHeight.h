//
//  UILabel+EstimatedHeight.h
//  ClaroViajes
//
//  Created by Facundo Menzella on 11/12/15.
//  Copyright (c) 2015 Monits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (EstimatedHeight)

- (CGFloat)numberOfLinesForWidth:(CGFloat)width;
- (CGFloat)heightForText:(NSString*)str withWidth:(CGFloat)width usingFont:(UIFont *)font;

@end
