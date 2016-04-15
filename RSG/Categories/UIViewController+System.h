//
//  UIViewController+System.h
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (System)

-(void) setupSlideOutButton;
-(void) showAlertViewWithError: (NSError*) error;
-(void) showAlertViewWithError: (NSError*) error customTitle: (NSString *) customTitle;

@end
