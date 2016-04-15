//
//  UIViewController+System.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import "UIViewController+System.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Helpers.h"

#define NetworkErrorForbidden 401
#define NetworkErrorOffline -1009

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

-(void) showAlertViewWithError: (NSError*) error {
    [self showAlertViewWithError: error customTitle: nil];
}

-(NSString *) errorText: (NSError *)error {
    NSString *errorText = nil;
    if (error.code == NetworkErrorOffline) {
        errorText = L(@"The Internet connection appears to be offline");
    }
    else {
        errorText = error.localizedDescription;
    }
    
    return errorText;
    
}

-(void) showAlertViewWithError: (NSError*) error customTitle: (NSString *) customTitle {
    NSString *title = customTitle?customTitle:L(@"Error");
    //logout on anauthorized
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD showFailHudAddedToWindowWithText: title detailsText: [self errorText: error] completion:^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView: frontWindow];
        [hud hide: YES];
    }];
}



@end
