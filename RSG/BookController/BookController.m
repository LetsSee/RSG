//
//  BookController.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "BookController.h"
#import "ChapterContainer.h"


@interface BookController ()

@end

@implementation BookController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.chapterContainers = [NSMutableArray array];
        self.chapterNumber = 0;
        self.currentPage = 0;
        //ChapterContainer *container = [[ChapterContainer alloc] initWithChapter: self.chapterNumber delegate: self];
        //[self.chapterContainers setObject: container forKey: @(self.chapterNumber)];
        [self initEntireBook];
    }
    return self;
}

-(void) initEntireBook {
    for (NSUInteger i = 0; i < 12; i++) {
        ChapterContainer *container = [[ChapterContainer alloc] initWithChapter: i delegate: self];
        [self.chapterContainers addObject: container];
    }
}

-(void) fillEntireBook {
    NSUInteger i = 0;
    for(ChapterContainer *container in self.chapterContainers) {
        [container fillTextContainers: self.view.bounds.size];
        container.pagesBefore = i;
        i += container.pageCount;
    }
    self.totalPageCount = i;
}

-(void) pageNumber {
    
}

- (void)viewDidLoad {
    self.navigationItem.title = L(@"RSG");
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
    [self fillEntireBook];
    [self.pageViewController setViewControllers: @[[self viewControllerForPageNumber:0]] direction:UIPageViewControllerNavigationDirectionForward animated: YES completion:nil];
}

- (NSLayoutManager *)layoutManager {
    ChapterContainer *container = [self.chapterContainers objectAtIndex: self.chapterNumber];
    return container.layoutManager;
}

- (NSTextStorage *)textStorage {
    ChapterContainer *container = [self.chapterContainers objectAtIndex: self.chapterNumber];
    return container.textStorage;
}

-(ChapterContainer*) chapterContainer {
    ChapterContainer *container = [self.chapterContainers objectAtIndex: self.chapterNumber];
    return container;
}


- (UIViewController *)viewControllerForPageNumber:(NSUInteger) pageNumber {
    ChapterContainer *chapter = [self chapterContainer];
    NSTextContainer *container = [self.layoutManager.textContainers objectAtIndex: pageNumber];
    
    /*UIViewController *pageController = [[UIViewController alloc] init];
     [pageController.view setFrame: self.view.bounds];
     UITextView *textView = [[UITextView alloc] initWithFrame: self.view.bounds textContainer: container];
     textView.editable = NO;
     textView.scrollEnabled = NO;
     [pageController.view addSubview: textView];
     */
    /*SinglePageController *pageController = [[SinglePageController alloc] initWithPageNumber: pageNumber
                                                                                pagesBefore: chapter.pagesBefore
                                                                              textContainer: container
                                                                                   delegate: self];*/
    
    PageController *pageController = [[PageController alloc] initWithPageNumber: pageNumber
                                                                    pagesBefore: chapter.pagesBefore
                                                                     pagesTotal: self.totalPageCount
                                                                  textContainer: container
                                                                       delegate: self];
    return pageController;
}



#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.isTransitioning) {
        return nil;
    }
    if (self.currentPage == [[self chapterContainer] pageCount]-1) {
        self.chapterNumber++;
        self.currentPage = 0;
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
    if (self.currentPage == 0 && self.chapterNumber == 0) {
        return nil;
    }
    
    if (self.currentPage == 0) {
        if (self.chapterNumber > 0) {
            self.chapterNumber--;
            self.currentPage = [[self chapterContainer] pageCount]-1;
        }
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
        dst.chapterContainers = self.chapterContainers;
        dst.delegate = self;
    }
}


#pragma mark - MatterController Delegate

-(void) selectChapterAtIndex:(NSUInteger)index {
    self.chapterNumber = index;
    self.currentPage = 0;
    [self.pageViewController setViewControllers: @[[self viewControllerForPageNumber: self.currentPage]] direction:UIPageViewControllerNavigationDirectionForward animated: YES completion:nil];
    
}

-(void) selectParagraph:(NSUInteger)pageNumber chapterIndex:(NSUInteger)index {
    self.chapterNumber = index;
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

#pragma mark - SinglePageController Delegate

/*-(void) didDiplayViewController: (NSUInteger) pageNumber {
    if (pageNumber == [[self chapterContainer] pageCount]-1) {
        if (![self.chapterContainers objectForKey: @(self.chapterNumber+1)]) {
            ChapterContainer *container = [[ChapterContainer alloc] initWithChapter: self.chapterNumber+1 delegate: self];
            [self.chapterContainers setObject: container forKey: @(self.chapterNumber+1)];
            [container fillTextContainers: self.view.bounds.size];
        }
        
    }
    if (pageNumber == 0 && self.chapterNumber > 0) {
        if (![self.chapterContainers objectForKey: @(self.chapterNumber-1)]) {
            ChapterContainer *container = [[ChapterContainer alloc] initWithChapter: self.chapterNumber-1 delegate: self];
            [self.chapterContainers setObject: container forKey: @(self.chapterNumber-1)];
            [container fillTextContainers: self.view.bounds.size];
        }
    }
}*/

/*-(void) dealloc {
    self.chapterContainers = nil;
    self.layoutManager = nil;
    self.textStorage = nil;
}*/

@end