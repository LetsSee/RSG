//
//  City.m
//  RSG
//
//  Created by Rodion Bychkov on 04.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "City.h"
#import "Picture.h"

@implementation City

- (instancetype)initWithObj: (id) obj
{
    self = [super init];
    if (self) {
        if ([obj isKindOfClass: [NSDictionary class]]) {
            self.cityID = [obj objectForKey: @"CityID"];
            self.name = [obj objectForKey: @"Name"];
            NSArray *pics = [obj objectForKey: @"pics"];
            if ([pics isKindOfClass: [NSArray class]]) {
                NSMutableArray *picsArray = [NSMutableArray arrayWithCapacity: pics.count];
                for (NSDictionary *picObj in pics) {
                    Picture *p = [[Picture alloc] initWithObj: picObj];
                    [picsArray addObject: p];
                }
                self.pictures = [NSArray arrayWithArray: picsArray];
            }
        }
    }
    return self;
}

@end
