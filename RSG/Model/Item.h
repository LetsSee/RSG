//
//  Item.h
//  RSG
//
//  Created by Rodion Bychkov on 16.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *itemID;
@property (nonatomic) NSString *typeID;
@property (nonatomic) NSArray *pictures;
@property (nonatomic) NSString *descriptionText;

- (instancetype)initWithObj: (id) obj;

@end
