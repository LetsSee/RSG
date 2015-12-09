//
//  PageController.m
//  RSG
//
//  Created by Rodion Bychkov on 01.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "PageController.h"

@interface PageController ()

@property (nonatomic) NSUInteger pageNumber;
@property (nonatomic) NSUInteger pagesBefore;
@property (nonatomic) NSUInteger pagesTotal;
@property (nonatomic) NSTextContainer *textContainer;

@end

@implementation PageController

- (instancetype) initWithPageNumber: (NSUInteger) pageNumber
                        pagesBefore: (NSUInteger) pagesBefore
                         pagesTotal: (NSUInteger) pagesTotal
                      textContainer: (NSTextContainer *)textContainer
                           delegate: (id) delegate

{
    self = [super initWithNibName: @"PageController" bundle: nil];
    if (self) {
        self.pageNumber = pageNumber;
        self.pagesBefore = pagesBefore;
        self.pagesTotal = pagesTotal;
        self.textContainer = textContainer;
        self.delegate = delegate;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider setThumbImage: [UIImage imageNamed: @"circle"] forState: UIControlStateNormal];
    [self.slider setTintColor: OrangeColor];
    [self.slider setMaximumValue: self.pagesTotal];
    [self.slider setValue: self.pageNumber+self.pagesBefore+1 animated: NO];
    
    self.label.text = [NSString stringWithFormat: @"%ld of %ld", self.pageNumber+self.pagesBefore+1, self.pagesTotal];
    if (self.textContainer) {
        UITextView *textView = [[UITextView alloc] initWithFrame: self.containerView.bounds textContainer: self.textContainer];
        textView.editable = NO;
        //textView.scrollEnabled = NO;
        textView. autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.containerView addSubview: textView];
    }
}

/*-(void) viewDidAppear:(BOOL)animated {
 [super viewDidAppear: animated];
 if (self.delegate) {
 [self.delegate didDiplayViewController: self.pageNumber];
 }
 }*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
