//
//  UIGestureRecognizer+Blocks.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 28.11.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "UIGestureRecognizer+Blocks.h"

#import <objc/runtime.h> // Need the objective-c runtime for object associations

@implementation UIGestureRecognizer (Blocks)

// Create static reference pointer to access stored block operation
static char kUIGESTURERECOGNIZER_BLOCK_IDENTIFIER;

- (id)initWithBlock:(UIGestureRecognizerActionBlock)block {
    
    if (self = [self init]) {
        
        // Add a target/action to the recognizer, calling back to [self completionHandler]
        [self addTarget:self action:@selector(completionHandler)];
        
        // Wrap the passed in block inside an anonymous block, calling back with the UIGestureRecognizer
        // This allows the block to be stored in the NSBlockOperation object
        void (^callbackBlock)(void) = ^{
            if (block) {
                block();
            }
        };
        
        // Wrap the anonymous block in a block operation
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:callbackBlock];
        
        // Store the NSBlockOperation as an associated object of the UIGestureRecognizer
        // Associations are released automatically when the gestureregonizer is dealloced, so the block will be removed as well
        objc_setAssociatedObject(self, &kUIGESTURERECOGNIZER_BLOCK_IDENTIFIER, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self;
}

// This fires when the normal target:action fires
- (void)completionHandler {
    
    // Fetch the block operation from the association
    NSBlockOperation *blockOperation = (NSBlockOperation *)objc_getAssociatedObject(self, &kUIGESTURERECOGNIZER_BLOCK_IDENTIFIER);
    
    // If the block operation exists, call start. This invokes the anonymous block, in turn invoking the passed in block
    if (blockOperation) {
        CGPoint p = [self locationInView: self.view];
        CGRect sensitiveRect = CGRectMake(self.view.center.x-120, self.view.center.y-90, 240, 180);
        
        if (CGRectContainsPoint(sensitiveRect, p)) {
            [blockOperation start];
        }
    }
}

@end