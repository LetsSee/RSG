//
//  SectionController.h
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatterController.h"
#import "PageController.h"
#import "ChapterContainer.h"

@interface SectionController : UIViewController  <MatterControllerDelegate, UIGestureRecognizerDelegate, NSLayoutManagerDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, PageControllerDelegate>

@property (nonatomic) NSString *chapterName;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic) BOOL isTransitioning;
@property (nonatomic, retain) UIPageViewController *pageViewController;

@property (nonatomic, retain) ChapterContainer *chapterContainer;
@property (nonatomic, retain) NSLayoutManager *layoutManager;
@property (nonatomic, retain) NSTextStorage *textStorage;

@end
