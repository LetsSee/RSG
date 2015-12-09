//
//  CNRefreshPlaceholder.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 23.09.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "CNRefreshPlaceholder.h"
#import "UIScrollView+CNPullToRefresh.h"

@implementation CNRefreshPlaceholder

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]) {
        [self.scrollView scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }
    else if([keyPath isEqualToString:@"contentSize"]) {
        [self.scrollView scrollViewDidChangeContentSize: [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue] old: [[change valueForKey:NSKeyValueChangeOldKey] CGSizeValue]];
    }

}

- (id)initWithFrame:(CGRect)frame infinityMode: (BOOL) amode
{
    self = [super initWithFrame:frame];
    self->mode = amode;
    if (self) {
        if (amode) {
            self.refreshView = [[CNRefreshView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
            [self addSubview: self.refreshView];
        }
        else
        {
            self.refreshView = [[CNRefreshView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
            [self addSubview: self.refreshView];
            
        }
    }
    return self;
}


- (void) setPathLength: (CGFloat) length
{
    if (self.refreshView) {
        [self.refreshView setPathLength: length];
    }
}

-(void) startAnimation {
    if (self.isAnimating && self->mode) {
        return;
    }
    if (self.refreshView) {
        if (self->mode) {
            self.isAnimating = YES;
        }
        [self.refreshView startAnimation];
    }
}

-(void) startRotateAnimation {
    if (self.refreshView) {
        [self.refreshView startRotateAnimation];
    }
}

-(void) stopAnimation {
    if (self.refreshView) {
        if (self->mode) {
            self.isAnimating = NO;
        }
        [self.refreshView stopAnimation];
    }
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.refreshView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}


@end
