//
//  PositiveActionsMapView.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/16/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "PositiveActionsMapView.h"
#import "ButtonFactory.h"
#import "PositiveActionAnnotation.h"
#import "BeautyCenter.h"

#import <PureLayout/PureLayout.h>

@interface PositiveActionsMapView () <MKMapViewDelegate>

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *pledgeButton;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIImageView *fowardImageView;
@property (nonatomic, strong) UITextView *positiveActionTitle;

@property (nonatomic) BOOL didTapOnce;
@property (nonatomic, strong) NSArray *defaultConstraints;

@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, strong) MKCircle *userCircle;
@property (nonatomic, strong) MKCircleRenderer *circleOverlay;

@end

@implementation PositiveActionsMapView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        [self buildSubviews];
        [self styleSubviews];
        [self activate:NO];
    }
    return self;
}

- (void)addPositiveActions:(NSArray*)positiveActions
{
    [self.mapView removeAnnotations:self.annotations];
    self.annotations = positiveActions;
    [self.mapView addAnnotations:self.annotations];
}

- (void)showActivePositiveActionWithTitle:(NSString*)title withSubtitle:(NSString*)subttitle
{
    self.positiveActionTitle.text = title;
}

-(void)setRadio:(CLLocationDistance)radio enabled:(BOOL)enabled
{
    _radioEnabled = enabled;
    _radio = radio;
    [self.mapView removeOverlay:self.userCircle];
    if (_radioEnabled) {
        [self updateUserCircle];
    }
}

- (void)buildSubviews
{
    [self buildMapView];
    [self buildFooterView];
    [self buildButtons];
}

- (void)buildMapView
{
    self.mapView = [[MKMapView alloc] initForAutoLayout];
    self.mapView.delegate = self;
    [self addSubview: self.mapView];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.mapView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = NO;
    self.mapView.showsBuildings = NO;
}

- (void)buildButtons
{
    self.shareButton = [ButtonFactory buttonWithImage:@"share"];
    self.pledgeButton = [ButtonFactory buttonWithImage:@"pledge"];
    
    [self addSubview:self.shareButton];
    [self addSubview:self.pledgeButton];
    [self.shareButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:32];
    [self.pledgeButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.mapView withOffset:-32];
    
    [self.shareButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.footerView withOffset:-16];
    [self.pledgeButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.footerView withOffset:-16];
}

- (void)buildFooterView
{
    self.footerView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.footerView];
    
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.footerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapView];
    
    self.defaultConstraints = [NSLayoutConstraint autoCreateAndInstallConstraints:^{
        [self.footerView autoSetDimension:ALDimensionHeight toSize:0];
    }];
    
    [self buildFowardButton];
    [self buildPositiveActionTitle];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectDetail)];
    [self.footerView addGestureRecognizer:tap];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UITextView alloc] initForAutoLayout];
    self.positiveActionTitle.scrollEnabled = NO;
    self.positiveActionTitle.editable = NO;
    [self.footerView addSubview: self.positiveActionTitle];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop
                                               withInset:4];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                               withInset:4];
    
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.positiveActionTitle autoPinEdge:ALEdgeRight
                                   toEdge:ALEdgeLeft
                                   ofView:self.fowardImageView
                               withOffset:8
                                 relation:NSLayoutRelationGreaterThanOrEqual];
}

- (void)buildFowardButton
{
    self.fowardImageView = [[UIImageView alloc] initForAutoLayout];
    [self.fowardImageView setImage:[UIImage imageNamed:@"foward"]];
    [self.fowardImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.fowardImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.footerView addSubview:self.fowardImageView];
    [self.fowardImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.fowardImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.fowardImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                           withInset:0
                                            relation:NSLayoutRelationGreaterThanOrEqual];
    [self.fowardImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

#pragma mark - Style

- (void)styleSubviews
{
    [self.positiveActionTitle setTextColor: [UIColor whiteColor]];
    [self.positiveActionTitle setBackgroundColor:[UIColor clearColor]];
    [self.positiveActionTitle setTextAlignment:NSTextAlignmentCenter];
    [self.positiveActionTitle setFont: [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                      withSize:BeautyCenterTypographySizeB]];
    [self.footerView setBackgroundColor: [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed]];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[PositiveActionAnnotation class]]) {
        self.activeAnnotation = (PositiveActionAnnotation*)view.annotation;
        
        NSString *title = self.activeAnnotation.title;
        NSString *subtitle = self.activeAnnotation.pSubtitle;
        [self showActivePositiveActionWithTitle:title withSubtitle:subtitle];
        
        self.footerView.userInteractionEnabled = YES;
        
        if (!self.didTapOnce) {
            self.didTapOnce = !self.didTapOnce;
            [self activate:YES];
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // Handle any custom annotations.
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"mapPin"];
    if(aView){
        aView.annotation = annotation;
    } else {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapPin"];
    }
    
    if ([annotation isKindOfClass:[PositiveActionAnnotation class]]) {
        aView.image = ((PositiveActionAnnotation*)annotation).locationPinImage;
        aView.canShowCallout = YES;
    } else {
        [self updateUserCircle];
    }
    
    return aView;
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    self.circleOverlay = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    self.circleOverlay.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.6];
    self.circleOverlay.lineWidth = 2;
    self.circleOverlay.fillColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.2];
    return self.circleOverlay;
}

- (void)updateUserCircle
{
    // it's user pin
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude,
                                                                 self.mapView.userLocation.coordinate.longitude);
    self.userCircle = [MKCircle circleWithCenterCoordinate:location radius:self.radio];
    [self.mapView addOverlay:self.userCircle];
}

#pragma mark - UITransitions

- (void)activate:(BOOL)active
{
    if (active) {
        [UIView animateWithDuration:.4 animations:^{
            [self activateViews:active];
            
            [self.defaultConstraints autoRemoveConstraints];
            [self layoutIfNeeded];
        }];
    } else {
        [self activateViews:active];
    }
}

- (void)activateViews:(BOOL)active
{
    self.shareButton.hidden = !active;
    self.pledgeButton.hidden = !active;
}

- (void)zoomToMyLocation
{
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - Tap

- (void)didSelectDetail
{
    [self.pAMVDelegate didSelectDetail];
}

@end
