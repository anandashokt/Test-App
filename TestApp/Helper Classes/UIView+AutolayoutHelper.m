//
//  AppDelegate.h
//  TestApp
//
//  Created by Anand on 10/15/15.
//  Copyright (c) 2015 Anand. All rights reserved.
//


#import "UIView+AutolayoutHelper.h"

@implementation UIView (AutolayoutHelper)

// -------------------------------------------------------------------------------
/*
 @method        fitView
 @abstract      UIView - Set the AutoLayoutConstraints to subview
 @param         subView -Passing view to this method and set the Constraints to added subview
 @return        void
 */
// -------------------------------------------------------------------------------
- (void)fitView:(UIView *)subView {
    
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
}

@end
