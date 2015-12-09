//
//  CNRefreshView.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 18.09.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "CNRefreshView.h"

#define ANGLE(a) 2*M_PI/360*a

@implementation CNRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.anglePer = 0;
        self.currentRotation = 0;
    }
    return self;
}

- (void)setAnglePer:(CGFloat)anglePer
{
    _anglePer = anglePer;
    [self setNeedsDisplay];
}

- (void)startAnimation
{
    if (self.isAnimating) {
        [self stopAnimation];
        [self.layer removeAllAnimations];
    }
    _isAnimating = YES;
    
    self.anglePer = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                  target:self
                                                selector:@selector(drawPathAnimation:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}



- (void)stopAnimation
{
    _isAnimating = NO;
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self stopRotateAnimation];
}

- (void) setPathLength: (CGFloat) length
{
    if (!self.isRotating) {
        if (length >= 1) {
            self.anglePer = 1;
            [self rotate];
        }
        else
            self.anglePer = length;
    }
}


- (void)drawPathAnimation:(NSTimer *)timer
{
    if (!self.isRotating) {
        self.anglePer += 0.03f;
        
        if (self.anglePer >= 1) {
            self.anglePer = 1;
            [timer invalidate];
            self.timer = nil;
            [self startAutoRotateAnimation];
        }
    }

}
- (void) rotate {
    self.currentRotation+=0.11f;
    self.layer.transform = CATransform3DMakeRotation(self.currentRotation, 0.0, 0.0, 1.0);

    
    /*CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(self.currentRotation);
    self.currentRotation += 0.1f;
    NSLog(@"CURRENT ROTATION: %f", self.currentRotation);
    animation.toValue = @(self.currentRotation);
    animation.duration = 0.1f;
    animation.repeatCount = 1;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];*/
}

- (void)startAutoRotateAnimation
{
    self.isRotating = YES;
    self.anglePer = 1.0f;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    CGFloat destination = 4*M_PI;
    animation.toValue = @(destination);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}



- (void)startRotateAnimation
{
    self.isRotating = YES;
    self.anglePer = 1.0f;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(self.currentRotation);
    CGFloat destination = self.currentRotation + 4*M_PI;
    animation.toValue = @(destination);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
    __weak CNRefreshView *weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.anglePer = 0;
        [weakSelf.layer removeAllAnimations];
        weakSelf.alpha = 1;
        weakSelf.currentRotation = 0;
        weakSelf.layer.transform = CATransform3DMakeRotation(weakSelf.currentRotation, 0.0, 0.0, 1.0);
        weakSelf.isRotating = NO;
    }];
}

- (void)drawRect:(CGRect)rect
{
    if (self.anglePer <= 0) {
        _anglePer = 0;
    }
    
    CGFloat lineWidth = 1.9f;
    UIColor *lineColor = OrangeColor;
    if (self.lineWidth) {
        lineWidth = self.lineWidth;
    }
    if (self.lineColor) {
        lineColor = self.lineColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2-lineWidth,
                    ANGLE(120), ANGLE(120)+ANGLE(330)*self.anglePer,
                    0);
    CGContextStrokePath(context);
}


@end
