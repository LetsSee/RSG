//
//  Picture.m
//  RSG
//
//  Created by Rodion Bychkov on 04.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "Picture.h"

@implementation Picture

- (instancetype)initWithObj: (id) obj
{
    self = [super init];
    if (self) {
        if ([obj isKindOfClass: [NSDictionary class]]) {
            self.pictureID = [obj objectForKey: @"PictureID"];
        }
    }
    return self;
}

-(NSURL *) url {
    return [NSString stringWithFormat: @"https://aglas.blob.core.windows.net/rsg-city-s/%@.jpg", self.pictureID];
}

@end
