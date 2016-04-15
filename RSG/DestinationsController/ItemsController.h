//
//  ItemsController.h
//  RSG
//
//  Created by Rodion Bychkov on 16.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface ItemsController : UITableViewController

@property (nonatomic) NSNumber *type;
@property (nonatomic) NSArray *items;
@property (nonatomic) City *city;
@property (nonatomic) NSArray *photos;

@end
