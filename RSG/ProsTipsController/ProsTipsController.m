//
//  ProsTipsController.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "ProsTipsController.h"

@implementation ProsTipsController

- (void)viewDidLoad {
    self.navigationItem.title = L(ProsSegueKey);
    [self setupSlideOutButton];
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"tips-pros" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    self.webView.paginationMode = UIWebPaginationModeLeftToRight;
    self.webView.scrollView.pagingEnabled = YES;
    self.webView.scrollView.bounces = NO;
}


@end
