//
//  AuthorsController.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "AuthorsController.h"

@implementation AuthorsController

- (void)viewDidLoad {
    self.navigationItem.title = L(AuthorsSegueKey);
    [self setupSlideOutButton];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
