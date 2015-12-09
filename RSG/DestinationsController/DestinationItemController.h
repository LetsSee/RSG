//
//  DestinationItemController.h
//  RSG
//
//  Created by Rodion Bychkov on 17.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "City.h"

@interface DestinationItemController : UITableViewController <MWPhotoBrowserDelegate>


@property (nonatomic) City *city;
@property (nonatomic) NSMutableArray *photos;

@end
