//
//  TermsAndConditionsPresenter.h
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/23/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TermsAndConditionsPresenter : NSObject

@property (nonatomic, strong) NSString *htmlTermsAndConditions;

- (instancetype)initWithPathToHTML:(NSString*)pathToHTML;

@end
