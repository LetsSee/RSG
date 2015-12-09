//
//  UIViewController+System.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import "UIViewController+System.h"

@implementation UIViewController (System)

-(void) setupSlideOutButton {
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 31, 31)];
    [button setImage: [UIImage imageNamed: @"Menu_icon"] forState: UIControlStateNormal];
    [button addTarget: self action: @selector(onSlide) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView: button];
    self.navigationItem.leftBarButtonItem = barButton;
}

-(void) onSlide {
    [[NSNotificationCenter defaultCenter] postNotificationName: SlideOutNotificationKey object: self];
}

@end
