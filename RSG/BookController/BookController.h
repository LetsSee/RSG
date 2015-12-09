//
//  BookController.h
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatterController.h"
#import "PageController.h"

@interface BookController : UIViewController <UIWebViewDelegate, MatterControllerDelegate, UIGestureRecognizerDelegate, NSLayoutManagerDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, PageControllerDelegate>

@property (nonatomic) NSUInteger chapterNumber;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic) NSUInteger totalPageCount;
@property (nonatomic) BOOL isTransitioning;
@property (nonatomic, retain) UIPageViewController *pageViewController;

@property (nonatomic, retain) NSMutableArray *chapterContainers;
@property (nonatomic, retain) NSLayoutManager *layoutManager;
@property (nonatomic, retain) NSTextStorage *textStorage;

@end
