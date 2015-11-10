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

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIImageView *fowardImageView;
@property (nonatomic, strong) UILabel *positiveActionTitle;

@property (nonatomic) BOOL didTapOnce;
@property (nonatomic, strong) NSArray *defaultConstraints;
@property (nonatomic, strong) NSArray *activeConstraints;

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
    [self.footerView layoutIfNeeded];
}

-(void)setRadio:(CLLocationDistance)radio enabled:(BOOL)enabled
{
    _radioEnabled = enabled;
    _radio = radio;
    [self updateUserCircle];
}

- (void)buildSubviews
{
    [self buildMapView];
    [self buildFooterView];
}

- (void)buildMapView
{
    self.mapView = [[MKMapView alloc] initForAutoLayout];
    self.mapView.delegate = self;
    [self addSubview: self.mapView];
    [self.mapView autoPinEdgesToSuperviewEdges];
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = NO;
    self.mapView.showsBuildings = NO;
}

- (void)buildFooterView
{
    self.footerView = [[UIView alloc] initForAutoLayout];
    [self addSubview: self.footerView];
    
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.footerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    self.defaultConstraints = [NSLayoutConstraint autoCreateAndInstallConstraints:^{
        [self.footerView autoSetDimension:ALDimensionHeight toSize:0];
    }];
    
    [self buildPositiveActionTitle];
    [self buildFowardButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectDetail)];
    [self.footerView addGestureRecognizer:tap];
}

- (void)buildPositiveActionTitle
{
    self.positiveActionTitle = [[UILabel alloc] initForAutoLayout];
    [self.footerView addSubview: self.positiveActionTitle];
    [self.positiveActionTitle autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    
    self.activeConstraints = [NSLayoutConstraint autoCreateConstraintsWithoutInstalling:^{
        [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeTop
                                                   withInset:8];
        [self.positiveActionTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                                   withInset:8];
    }];
    
}

- (void)buildFowardButton
{
    self.fowardImageView = [[UIImageView alloc] initForAutoLayout];
    [self.fowardImageView setImage:[UIImage imageNamed:@"foward"]];
    [self.fowardImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.fowardImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.fowardImageView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                          forAxis:UILayoutConstraintAxisVertical];
    [self.fowardImageView setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                          forAxis:UILayoutConstraintAxisHorizontal];
    [self.footerView addSubview:self.fowardImageView];
    [self.fowardImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.fowardImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.fowardImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                           withInset:0
                                            relation:NSLayoutRelationGreaterThanOrEqual];
    [self.fowardImageView autoPinEdge:ALEdgeLeft
                               toEdge:ALEdgeRight ofView:self.positiveActionTitle
                           withOffset:8
                             relation:NSLayoutRelationGreaterThanOrEqual];
    [self.fowardImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

#pragma mark - Style

- (void)styleSubviews
{
    self.positiveActionTitle.textColor = [UIColor whiteColor];
    self.positiveActionTitle.backgroundColor = [UIColor clearColor];
    self.positiveActionTitle.textAlignment = NSTextAlignmentCenter;
    self.positiveActionTitle.numberOfLines = 2;
    [self.positiveActionTitle setFont: [BeautyCenter beautyCenterFontWithStyle:BeautyCenterTypographyStyleLight
                                                                      withSize:BeautyCenterTypographySizeB]];
    self.footerView.backgroundColor = [BeautyCenter beautyCenterColor:BeautyCenterColorDarkRed];
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
    if (!_radioEnabled) {
        [self.mapView removeOverlay:self.userCircle];
        return;
    }
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude,
                                                                 self.mapView.userLocation.coordinate.longitude);
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:location radius:self.radio];
    if (self.userCircle) {
        [self.mapView removeOverlay:self.userCircle];
    }
    [self.mapView addOverlay:circle];
    self.userCircle = circle;
}

#pragma mark - UITransitions

- (void)activate:(BOOL)active
{
    if (active) {
        [UIView animateWithDuration:.4 animations:^{
            [self.defaultConstraints autoRemoveConstraints];
            [self.activeConstraints autoInstallConstraints];
            [self layoutIfNeeded];
        }];
    }
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
