//
//  DestinationsController.m
//  RSG
//
//  Created by Rodion Bychkov on 12.09.15.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "DestinationsController.h"
#import "DestinationItemController.h"
#import "UIScrollView+CNPullToRefresh.h"
#import "HTTPClient.h"
#import "City.h"

@interface DestinationsController ()

@end

@implementation DestinationsController

- (void)viewDidLoad {
    self.navigationItem.title = L(DestinationsSegueKey);
    [self setupSlideOutButton];
    [super viewDidLoad];
    
    __weak DestinationsController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [[HTTPClient sharedHTTPClient] getCityList:^(BOOL success, NSError *error, NSArray *cities) {
            if (success) {
                weakSelf.citiesList = cities;
                [weakSelf.tableView reloadData];
            }
            else {
                NSLog(@"Error: %@", error);
            }
            [weakSelf.tableView stopPullToRefresh];
        }];
    } noItemsText: @"No cities loaded"];
    [self.tableView triggerPullToRefreshWithShift: NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.citiesList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MediumRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier: @"DestinationCell" forIndexPath: indexPath];
    //cell.textLabel.font = [UIFont fontWithName: @"IowanOldStyle-Roman" size: 17.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tintColor = OrangeColor;
    
    City *city = [self.citiesList objectAtIndex: indexPath.row];
    cell.textLabel.text = city.name.length ? city.name : @"No name city";
    return cell;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: DestinationItemSegueKey]) {
        DestinationItemController *dst = (DestinationItemController*)segue.destinationViewController;
        NSIndexPath *ip = [self.tableView indexPathForCell: sender];
        dst.city = [self.citiesList objectAtIndex: ip.row];
    }
}


@end
