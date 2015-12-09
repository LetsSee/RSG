//
//  NavigationCell.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import "NavigationCell.h"

@implementation NavigationCell

-(void)awakeFromNib {
    self.backgroundColor = DarkGrayColor;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = WhiteColor;
    self.textLabel.font = [UIFont systemFontOfSize: 15.0];
    
    
    UIView *customBgView = [[UIView alloc] init];
    customBgView.backgroundColor = BlackColor;
    customBgView.layer.masksToBounds = YES;
    self.selectedBackgroundView = customBgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected) {
        return;
    }
    [super setSelected:selected animated:animated];
    
}

@end
