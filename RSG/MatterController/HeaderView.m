//
//  HeaderView.m
//  RSG
//
//  Created by Rodion Bychkov on 15.04.16.
//  Copyright © 2016 LetsSee. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(void) awakeFromNib {
    [self.button.titleLabel setFont: [UIFont fontWithName: @"IowanOldStyle-Bold" size: 17.0f]];
    [self.button.titleLabel setNumberOfLines: 0];
    [self.button.titleLabel setTextAlignment: NSTextAlignmentLeft];
    [self.button setContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
    self.button.backgroundColor = WhiteColor;
}

@end
