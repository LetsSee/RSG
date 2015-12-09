//
//  CNRefreshPlaceholder.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 23.09.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNRefreshView.h"

@interface CNRefreshPlaceholder : UIView {
    BOOL mode;
}

@property (nonatomic, copy) void (^pullToRefreshActionHandler)(void);
@property (nonatomic, copy) void (^infinityActionHandler)(void);

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) CNRefreshView *refreshView;


@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isAnimating;;
@property (nonatomic) BOOL isObserving;
@property (nonatomic) BOOL isPulledEnough;
@property (nonatomic) BOOL isAlreadyUsed;
@property (nonatomic) BOOL needTriger;
@property (nonatomic) BOOL makeUnused;
@property (nonatomic) NSNumber *topContentInset;

- (id)initWithFrame:(CGRect)frame infinityMode: (BOOL) mode;

- (void) setPathLength: (CGFloat) length;
- (void) startAnimation;
- (void) startRotateAnimation;
- (void) stopAnimation;

@end
