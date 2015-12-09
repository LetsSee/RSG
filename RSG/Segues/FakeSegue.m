//
//  FakeSegue.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 23.06.14.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "FakeSegue.h"

@implementation FakeSegue

- (void)perform
{
    UIViewController *src = self.sourceViewController;
    UIViewController *dst = self.destinationViewController;
    dst.view.frame = src.view.bounds;
    dst.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

@end
