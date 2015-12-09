//
//  CNRefreshView.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 18.09.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNRefreshView : UIView

@property (nonatomic, assign) CGFloat anglePer;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) BOOL isRotating;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, readonly) BOOL isAnimating;

@property (nonatomic) CGFloat currentRotation;

//use this to init
- (id)initWithFrame:(CGRect)frame;

- (void)startAnimation;
- (void)stopAnimation;
- (void)startRotateAnimation;
- (void) setPathLength: (CGFloat) length;

@end
