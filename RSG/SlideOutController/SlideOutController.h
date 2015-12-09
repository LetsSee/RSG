//
//  SlideOutController.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 14.05.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentController.h"

@interface CNSlideOutController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITapGestureRecognizer *tapGesture;
    UISwipeGestureRecognizer *swipeGesture;
    UISwipeGestureRecognizer *swipeOutGesture;
    NSIndexPath *selectedIndexPath;
    UIViewController *current;
}



@property (weak, nonatomic) IBOutlet UITableView *navigationTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@property (nonatomic) ContentController *contentController;


@end
