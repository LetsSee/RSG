//
//  UIScrollView+CNPullToRefresh.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 25.10.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNRefreshView.h"
#import "CNRefreshPlaceholder.h"

@interface UIScrollView (CNPullToRefresh) <UIScrollViewDelegate>

- (void) addPullToRefreshWithActionHandler:(void (^)(void))actionHandler;
- (void) addPullToRefreshWithActionHandler:(void (^)(void))actionHandler noItemsText: (NSString *) noItemsText;
- (void) addInfinityhWithActionHandler:(void (^)(void))actionHandler;


- (void) triggerPullToRefreshWithShift:(BOOL) shift;
- (void) stopPullToRefresh;
- (void) stopInfinityLoading;
- (void) reappearInfinityLoading;

-(void) stopPullToRefreshObserving;
-(void) stopInfinityObserving;


@property (nonatomic, weak, readonly) CNRefreshPlaceholder *pullToRefreshView;
@property (nonatomic, weak, readonly) UILabel *noItemsLabel;
@property (nonatomic, weak, readonly) CNRefreshPlaceholder *infinityView;


-(void) scrollViewDidChangeContentSize:(CGSize) newSize old: (CGSize) oldSize;
-(void) scrollViewDidScroll:(CGPoint) point;


@end
