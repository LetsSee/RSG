//
//  MBProgressHUD+Helpers.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 28.11.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UIGestureRecognizer+Blocks.h"

@interface MBProgressHUD (Helpers)

+ (instancetype) showFailHudAddedToWindowWithText: (NSString *) text detailsText: (NSString*) detailsText;
+ (instancetype) showFailHudAddedToWindowWithText: (NSString *) text detailsText: (NSString*) detailsText completion :(UIGestureRecognizerActionBlock) completion;

@end
