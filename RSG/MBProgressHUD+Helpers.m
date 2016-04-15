//
//  MBProgressHUD+Helpers.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 28.11.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "MBProgressHUD+Helpers.h"
#import "UIGestureRecognizer+Blocks.h"

@implementation MBProgressHUD (Helpers)


+ (instancetype) showFailHudAddedToWindowWithText: (NSString *) text detailsText: (NSString*) detailsText {
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: frontWindow animated: YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross_red"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    hud.detailsLabelText = [NSString stringWithFormat: L(@"%@\n\nTap to dismiss"), detailsText];
    UITapGestureRecognizer *tapRecognizer  = [[UITapGestureRecognizer alloc] initWithBlock:^{
        [self hideHUDForView: frontWindow animated: YES];
    }];
    [hud addGestureRecognizer: tapRecognizer];
    return hud;
}


+ (instancetype) showFailHudAddedToWindowWithText: (NSString *) text detailsText: (NSString*) detailsText completion :(UIGestureRecognizerActionBlock) completion {
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: frontWindow animated: YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross_red"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    
    if (completion) {
        hud.detailsLabelText = [NSString stringWithFormat: L(@"%@\n\nTap to continue"), detailsText];
        UITapGestureRecognizer *tapRecognizer  = [[UITapGestureRecognizer alloc] initWithBlock: completion];
        [hud addGestureRecognizer: tapRecognizer];
    }
    else {
        hud.detailsLabelText = detailsText;
    }
    return hud;
}


@end
