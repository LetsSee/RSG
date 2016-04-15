//
//  SectionController.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "SectionController.h"

@implementation SectionController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.currentPage = 0;
    }
    return self;
}

-(void) setChapterName:(NSString *)chapterName {
    _chapterName = chapterName;
    if (self.chapterContainer == nil) {
        self.chapterContainer = [[ChapterContainer alloc] initWithChapterName: chapterName delegate: self];
    }
}


- (void)viewDidLoad {
    [self setupSlideOutButton];
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle: UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal
                                                                            options: nil];
    
    [self addChildViewController: self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.chapterContainer fillTextContainers: self.view.bounds.size];
    [self.pageViewController setViewControllers: @[[self viewControllerForPageNumber:0]] direction:UIPageViewControllerNavigationDirectionForward animated: YES completion:nil];
}


- (UIViewController *)viewControllerForPageNumber:(NSUInteger) pageNumber {
    PageController *pageController = [[PageController alloc] initWithPageNumber: pageNumber
                                                                    pagesBefore: 0
                                                                     pagesTotal: self.chapterContainer.pageCount
                                                                  textContainer: [self.chapterContainer.layoutManager.textContainers objectAtIndex: pageNumber]
                                                                       delegate: self];
    return pageController;
}



#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.isTransitioning) {
        return nil;
    }
    if (self.currentPage == self.chapterContainer.pageCount-1) {
        return nil;
    }
    else {
        self.currentPage++;
    }
    return [self viewControllerForPageNumber: self.currentPage];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.isTransitioning) {
        return nil;
    }
    if (self.currentPage == 0) {
        return nil;
    }
    else {
        self.currentPage--;
    }
    
    return [self viewControllerForPageNumber: self.currentPage];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: MattersSegueKey]) {
        UINavigationController *controller = segue.destinationViewController;
        MatterController *dst = (MatterController*)controller.topViewController;
        dst.chapterContainers = [NSMutableArray arrayWithObject: self.chapterContainer];
        dst.delegate = self;
    }
}


#pragma mark - MatterController Delegate

-(void) selectChapterAtIndex:(NSUInteger)index {
    self.currentPage = 0;
    [self.pageViewController setViewControllers: @[[self viewControllerForPageNumber: self.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated: YES completion:nil];
    
}

-(void) selectParagraph:(NSUInteger)pageNumber chapterIndex:(NSUInteger)index {
    self.currentPage = pageNumber;
    [self.pageViewController setViewControllers: @[[self viewControllerForPageNumber: self.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated: YES completion:nil];
}


#pragma mark - UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.isTransitioning = YES;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.isTransitioning = NO;
}


@end
