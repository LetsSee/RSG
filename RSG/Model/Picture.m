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

-(NSURL *) cityThumbUrl {
    NSString *str = [NSString stringWithFormat: @"https://aglas.blob.core.windows.net/rsg-city-s/%@.jpg", self.pictureID];
    return [NSURL URLWithString: str];
}

-(MWPhoto *) cityThumb  {
    return [MWPhoto photoWithURL: [self cityThumbUrl]];
}

-(MWPhoto *) cityPhoto  {
    NSString *str = [NSString stringWithFormat: @"https://aglas.blob.core.windows.net/rsg-city-l/%@.jpg", self.pictureID];
    return [MWPhoto photoWithURL: [NSURL URLWithString: str]];
}

-(NSURL *) thumbURLOfType: (NSString *) type  {
    NSString *str = [NSString stringWithFormat: @"https://aglas.blob.core.windows.net/rsg-item-%@-s/%@.jpg", type, self.pictureID];
    return [NSURL URLWithString: str];
}

-(MWPhoto *) thumbOfType: (NSString *) type  {
    NSString *str = [NSString stringWithFormat: @"https://aglas.blob.core.windows.net/rsg-item-%@-s/%@.jpg", type, self.pictureID];
    return [MWPhoto photoWithURL: [NSURL URLWithString: str]];
}

-(MWPhoto *) photoOfType: (NSString *) type  {
    NSString *str = [NSString stringWithFormat: @"https://aglas.blob.core.windows.net/rsg-item-%@-l/%@.jpg", type, self.pictureID];
    return [MWPhoto photoWithURL: [NSURL URLWithString: str]];
}



@end
