//
//  UIGestureRecognizer+Blocks.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 28.11.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import <UIKit/UIKit.h>

// Declare a completion block to be called when the action fires
typedef void (^UIGestureRecognizerActionBlock)(void);

@interface UIGestureRecognizer (Blocks)

// New initializer for the gesture recognizer with blocks
- (id)initWithBlock:(UIGestureRecognizerActionBlock)block;

@end