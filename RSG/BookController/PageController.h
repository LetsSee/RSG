//
//  PageController.h
//  RSG
//
//  Created by Rodion Bychkov on 01.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControllerDelegate <NSObject>

//-(void) didDiplayViewController: (NSUInteger) pageNumber;

@end

@interface PageController : UIViewController


@property (nonatomic, weak) id <PageControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *containerView;


- (instancetype) initWithPageNumber: (NSUInteger) pageNumber
                        pagesBefore: (NSUInteger) pagesBefore
                         pagesTotal: (NSUInteger) pagesTotal
                      textContainer: (NSTextContainer *)textContainer
                           delegate: (id) delegate;

@end
