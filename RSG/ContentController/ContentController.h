//
//  ContentController.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 23.06.14.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ContentController : UIViewController <UINavigationControllerDelegate, UISplitViewControllerDelegate>{
    NSMutableDictionary *controllers;
    NSArray *existingControllers;
}

@property (nonatomic) UIViewController *currentController;
@property (nonatomic) NSString *currentKey;

-(void) showControllerWithStoryboardId: (NSString *) stringId;

-(void) freeAllControllers;

@end
