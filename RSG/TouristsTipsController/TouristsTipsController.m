//
//  TouristsTipsController.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "TouristsTipsController.h"

@implementation TouristsTipsController

- (void)viewDidLoad {
    self.navigationItem.title = L(TouristsSegueKey);
    [self setupSlideOutButton];
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"tips-tourists" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    self.webView.paginationMode = UIWebPaginationModeLeftToRight;
    self.webView.scrollView.pagingEnabled = YES;
    self.webView.scrollView.bounces = NO;
}


@end
