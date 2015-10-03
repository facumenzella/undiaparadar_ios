
//
//  PositiveActionAnnotation.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/30/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionAnnotation.h"
#import "PositiveAction.h"

#import "TopicService.h"

@interface PositiveActionAnnotation ()

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readwrite) UIImage *locationPinImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pSubtitle;

@end

@implementation PositiveActionAnnotation

-(id)initWithPositiveAction:(PositiveAction*)positiveAction
{
    self = [super init];
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake(positiveAction.latitude, positiveAction.longitude);
        self.name = positiveAction.title;
        self.pSubtitle = positiveAction.subtitle;
        self.locationPinImage = [UIImage imageNamed:[TopicService onAnnotationImageById:positiveAction.topicID]];
    }
    return self;
}

- (NSString*)title
{
    return self.name;
}

- (NSString*)pSubtitle
{
    return _pSubtitle;
}

@end
