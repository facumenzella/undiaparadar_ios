//
//  ButtonFactory.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/3/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonFactory : NSObject

+ (UIButton*)menuButton;
+ (UIButton*)nextButton;
+ (UIButton*)buttonWithImage:(NSString*)img;

@end
