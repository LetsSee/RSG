//
//  AuthorsController.h
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorsController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

@end
