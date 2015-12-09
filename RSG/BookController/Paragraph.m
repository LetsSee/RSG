//
//  Paragraph.m
//  RSG
//
//  Created by Rodion Bychkov on 02.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "Paragraph.h"

@implementation Paragraph

- (instancetype)initWithTitle: (NSString *) title pageNumber: (NSUInteger) pageNumber
{
    self = [super init];
    if (self) {
        self.title = title;
        self.pageNumber = pageNumber;
    }
    return self;
}
@end
