//
//  City.h
//  RSG
//
//  Created by Rodion Bychkov on 04.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *cityID;
@property (nonatomic) NSArray *pictures;

- (instancetype)initWithObj: (id) obj;

@end
