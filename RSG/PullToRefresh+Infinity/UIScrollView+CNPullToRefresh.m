//
//  UIScrollView+CNPullToRefresh.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 25.10.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "UIScrollView+CNPullToRefresh.h"
#import <objc/runtime.h>

static char UIScrollViewPullToRefreshView;
static char UIScrollViewInfinityView;
static char UILabelNoItems;

@implementation UIScrollView (CNPullToRefresh)


@dynamic pullToRefreshView;
@dynamic infinityView;
@dynamic noItemsLabel;


- (void)setPullToRefreshView:(CNRefreshPlaceholder *)pullToRefreshView {
    [self willChangeValueForKey:@"PullToRefreshView"];
    objc_setAssociatedObject(self, &UIScrollViewPullToRefreshView,
                             pullToRefreshView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"PullToRefreshView"];
}

- (CNRefreshPlaceholder *)pullToRefreshView {
    return objc_getAssociatedObject(self, &UIScrollViewPullToRefreshView);
}


- (void)setInfinityView:(CNRefreshPlaceholder *)infinityView {
    [self willChangeValueForKey:@"InfinityView"];
    objc_setAssociatedObject(self, &UIScrollViewInfinityView,
                             infinityView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"InfinityView"];
}

- (CNRefreshPlaceholder *)infinityView {
    return objc_getAssociatedObject(self, &UIScrollViewInfinityView);
}


-(void) setNoItemsLabel:(UILabel *)noItemsLabel {
    [self willChangeValueForKey:@"NoItemsLabel"];
    objc_setAssociatedObject(self, &UILabelNoItems,
                             noItemsLabel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"NoItemsLabel"];
}

-(UILabel *) noItemsLabel {
    return objc_getAssociatedObject(self, &UILabelNoItems);
}


- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler {
    
    if(!self.pullToRefreshView) {
        
        CNRefreshPlaceholder *view = [[CNRefreshPlaceholder alloc] initWithFrame:CGRectMake(0, -StandartRowHeight, self.frame.size.width, StandartRowHeight) infinityMode: NO];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        view.pullToRefreshActionHandler = actionHandler;
        view.scrollView = self;
        [self addSubview:view];
        
        self.pullToRefreshView = view;
        [self startPullToRefreshObserving];
    }
    
}

- (void) addPullToRefreshWithActionHandler:(void (^)(void))actionHandler noItemsText: (NSString *) noItemsText {
    [self addPullToRefreshWithActionHandler: actionHandler];
    
    if (noItemsText.length) {
        if (!self.noItemsLabel) {
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.bounds.size.width, 70)];
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName: LightFontName size: 17.0f];
            label.textColor = OrangeColor;
            label.numberOfLines = 2;
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview: label];
            label.hidden = YES;
            self.noItemsLabel = label;
        }
        self.noItemsLabel.text = noItemsText;
    }
    
}


- (void) addInfinityhWithActionHandler:(void (^)(void))actionHandler {
    if(!self.infinityView) {
        
        CNRefreshPlaceholder *view = [[CNRefreshPlaceholder alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.frame.size.width, StandartRowHeight) infinityMode: YES];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        view.infinityActionHandler = actionHandler;
        view.scrollView = self;
        [self addSubview:view];
        
        self.infinityView = view;
        [self startInfinityObserving];
    }
    
}

-(void) startPullToRefreshObserving {
    [self addObserver: self.pullToRefreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void) startInfinityObserving {
    [self addObserver: self.infinityView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver: self.infinityView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

-(void) stopPullToRefreshObserving {
    [self removeObserver: self.pullToRefreshView forKeyPath:@"contentOffset"];
    
}

-(void) stopInfinityObserving {
    [self removeObserver: self.infinityView forKeyPath:@"contentOffset"];
    [self removeObserver: self.infinityView forKeyPath:@"contentSize"];
}

- (void)triggerPullToRefreshWithShift:(BOOL) shift {
    if (self.pullToRefreshView.isLoading) {
        return;
    }
    self.pullToRefreshView.isLoading = YES;
    self.pullToRefreshView.topContentInset = [NSNumber numberWithFloat: self.contentInset.top];
    [self.pullToRefreshView startAnimation];
    __weak UIScrollView *weakSelf = self;
    [UIView animateWithDuration: 0.3 animations:^{
        if (shift) {
            weakSelf.contentOffset = CGPointMake(weakSelf.contentOffset.x, weakSelf.contentOffset.y - StandartRowHeight);
        }
        weakSelf.contentInset = UIEdgeInsetsMake(self.contentInset.top + StandartRowHeight, 0, 0, 0);
    } completion:^(BOOL finished) {
        if (weakSelf.pullToRefreshView.pullToRefreshActionHandler) {
            weakSelf.pullToRefreshView.pullToRefreshActionHandler();
        }
        
    }];
}

- (void) stopPullToRefresh {
    if (self.pullToRefreshView.isLoading)
    {
        self.pullToRefreshView.isLoading = NO;
        [self.pullToRefreshView stopAnimation];
        
        __weak UIScrollView *weakSelf = self;
        [UIView animateWithDuration: 0.3 animations:^{
            weakSelf.contentInset = UIEdgeInsetsMake(weakSelf.pullToRefreshView.topContentInset.floatValue, 0, 0, 0);
        } completion: nil];
        
    }
}

-(void) startPullToRefresh {
    
    if (self.pullToRefreshView.isLoading) {
        return;
    }
    
    self.pullToRefreshView.isLoading = YES;
    if (self.pullToRefreshView.topContentInset == nil) {
        NSLog(@"SET AGAIN");
        self.pullToRefreshView.topContentInset = [NSNumber numberWithFloat: self.contentInset.top];
    }
    [self.pullToRefreshView startRotateAnimation];
    __weak UIScrollView *weakSelf = self;
    [UIView animateWithDuration: 0.3 animations:^{
        weakSelf.contentInset = UIEdgeInsetsMake(self.contentInset.top + StandartRowHeight, 0, 0, 0);
    } completion:^(BOOL finished) {
        if (weakSelf.pullToRefreshView.pullToRefreshActionHandler) {
            weakSelf.pullToRefreshView.pullToRefreshActionHandler();
        }
        
    }];
    
}


-(void) stopInfinityLoading {
    if (!self.infinityView.isLoading)
        NSLog(@"Autoload!");
    if (self.infinityView.isLoading) {
        [self.infinityView stopAnimation];
        self.infinityView.isLoading = NO;
    }
}

- (void) reappearInfinityLoading {
    self.infinityView.makeUnused = YES;
}

-(void) scrollViewDidScroll:(CGPoint) point {
    CGFloat scrollOffset = point.y+self.contentInset.top;
    
    if (!(self.bounds.size.height>0)) {
        return;
    }
    
    //its only for refresher
    if (scrollOffset < 0) {
        CGFloat length = (fabs(scrollOffset))/44.0f - 0.1;
        [self.pullToRefreshView setPathLength: length];
        
        
        if (!self.pullToRefreshView.isLoading) {
            if (scrollOffset <= - StandartRowHeight) {
                self.pullToRefreshView.isPulledEnough = YES;
            }
        }
        
        
        if (!self.isDragging) {
            if ((fabs(scrollOffset) < StandartRowHeight) && self.pullToRefreshView.isPulledEnough) {
                [self startPullToRefresh];
                self.pullToRefreshView.isPulledEnough = NO;
            }
        }
    }
    else {
        CGFloat scrollOffsetThreshold = self.contentSize.height-self.bounds.size.height;
        if (scrollOffsetThreshold > 0) {
            //NSLog(@"SCROLL OFFSET: %f (%f)", scrollOffset, scrollOffsetThreshold);
            if (scrollOffset < scrollOffsetThreshold && self.infinityView.makeUnused) {
                self.infinityView.makeUnused = NO;
                self.infinityView.isAlreadyUsed = NO;
            }
            else {
                if (scrollOffset > (scrollOffsetThreshold-1) && !self.infinityView.isLoading && !self.infinityView.isAlreadyUsed) {
                    self.infinityView.isAlreadyUsed = YES;
                    [self.infinityView startAnimation];
                }
                
                if (!self.isDragging) {
                    if (scrollOffset > scrollOffsetThreshold) {
                        if (!self.infinityView.isLoading && self.infinityView.isAnimating) {
                            self.infinityView.isLoading = YES;
                            //NSLog(@"Scroll offset threshold: %f", scrollOffsetThreshold);
                            self.infinityView.infinityActionHandler();
                        }
                    }
                }
            }
        }
    }
}


-(void) scrollViewDidChangeContentSize:(CGSize) newSize old: (CGSize) oldSize {
    if (self.infinityView) {
        self.infinityView.frame = CGRectMake(0, self.contentSize.height, self.frame.size.width, StandartRowHeight);
        self.contentInset = UIEdgeInsetsMake(self.contentInset.top, 0, StandartRowHeight, 0);
        if (!CGSizeEqualToSize(newSize, oldSize)) {
            self.infinityView.isAlreadyUsed = NO;
        }
        
    }
    if (self.pullToRefreshView) {
        if (newSize.height < 1) {
            self.noItemsLabel.hidden = NO;
        }
        else {
            self.noItemsLabel.hidden = YES;
        }
    }
}

@end
