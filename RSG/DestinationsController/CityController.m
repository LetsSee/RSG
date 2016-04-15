//
//  CityController.m
//  RSG
//
//  Created by Rodion Bychkov on 17.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import "CityController.h"
#import "CityPicturesController.h"
#import "UIScrollView+CNPullToRefresh.h"
#import "HTTPClient.h"
#import "ItemsController.h"

@interface CityController ()

@end

@implementation CityController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.city) {
        self.navigationItem.title = self.city.name;
    }
    __weak CityController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [[HTTPClient sharedHTTPClient] getItemsListCityID: weakSelf.city.cityID completion:^(BOOL success, NSError *error, NSArray *items) {
            if (success) {
                weakSelf.city.items = items;
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

-(void) setCity:(City *)city {
    _city = city;
    self.navigationItem.title = city.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LargeRowHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame: CGRectZero];
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(15, 0, self.view.bounds.size.width-20, LargeRowHeight)];
    label.numberOfLines = 2;
    label.font = [UIFont fontWithName: @"HelveticaNeue-Light" size: 14.0f];
    label.textColor = [UIColor darkGrayColor];
    switch (section) {
        case 0:
            label.text = [@"You will find all of the most famous international hotel chains in Russia" uppercaseString];
            break;
        case 1:
            label.text = [@"In the larger cities of Russia, you can find wonderful art museums" uppercaseString];
            break;
        case 2:
            label.text = [@"Some of the best restaurants in the world are located in Moscow" uppercaseString];
            break;
            
        default:
            label.text = @"";
            break;
    }
    [view addSubview: label];
    return view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MediumRowHeight;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"ItemCell" forIndexPath: indexPath];
    //cell.textLabel.font = [UIFont fontWithName: @"IowanOldStyle-Roman" size: 17.0f];

    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"Hotels";
            break;
        case 1:
            cell.textLabel.text = @"Museums";
            break;
        case 2:
            cell.textLabel.text = @"Restaurants";
            break;
            
        default:
            cell.textLabel.text = @"";
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tintColor = OrangeColor;
    return cell;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: CityPicturesSegueKey]) {
        CityPicturesController *dst = (CityPicturesController*)segue.destinationViewController;
        dst.pictures = self.city.pictures;
    }
    if ([segue.identifier isEqualToString: CityItemsSegueKey]) {
        ItemsController *dst = (ItemsController*)segue.destinationViewController;
        UITableViewCell *cell = sender;
        NSIndexPath *ip = [self.tableView indexPathForCell: cell];
        
        
        dst.title = [NSString stringWithFormat: @"%@ %@", self.city.name, cell.textLabel.text];
        dst.city = self.city;
        dst.type = [NSNumber numberWithInteger: ip.section+1];
    }
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if (self.tableView.pullToRefreshView) {
        [self.tableView stopPullToRefresh];
        [self.tableView stopPullToRefreshObserving];
    }
    
#ifdef DEBUG
    NSLog(@"%@ deallocated", NSStringFromClass([self class]));
#endif
}

@end
