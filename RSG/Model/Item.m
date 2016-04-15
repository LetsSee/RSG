//
//  Item.m
//  RSG
//
//  Created by Rodion Bychkov on 16.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "Item.h"
#import "Picture.h"

@implementation Item

- (instancetype)initWithObj: (id) obj
{
    self = [super init];
    if (self) {
        if ([obj isKindOfClass: [NSDictionary class]]) {
            self.itemID = [obj objectForKey: @"ItemID"];
            self.typeID = [obj objectForKey: @"TypeID"];
            self.name = [obj objectForKey: @"Name"];
            self.descriptionText = [obj objectForKey: @"Description"];
            NSArray *pics = [obj objectForKey: @"Pictures"];
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
