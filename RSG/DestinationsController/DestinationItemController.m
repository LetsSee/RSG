//
//  DestinationItemController.m
//  RSG
//
//  Created by Rodion Bychkov on 17.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import "DestinationItemController.h"
#import "CityPicturesController.h"

@interface DestinationItemController ()

@end

@implementation DestinationItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.city) {
        self.navigationItem.title = self.city.name;
    }
    // Do any additional setup after loading the view.
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Hotels";
            break;
        case 1:
            return @"Restaurants";
            break;
        case 2:
            return @"Museums";
            break;
            
        default:
            return @"";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return StandartRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame: CGRectZero];
    //view.backgroundColor = OrangeColor;
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(15, 0, 300, 44)];
    //label.font = [UIFont fontWithName: @"IowanOldStyle-Bold" size: 17.0f];
    label.textColor = [UIColor darkGrayColor];
    switch (section) {
        case 0:
            label.text = @"Hotels";
            break;
        case 1:
            label.text = @"Restaurants";
            break;
        case 2:
            label.text = @"Museums";
            break;
            
        default:
            label.text = @"";
            break;
    }
    [view addSubview: label];
    return view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MediumRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"ItemCell" forIndexPath: indexPath];
    //cell.textLabel.font = [UIFont fontWithName: @"IowanOldStyle-Roman" size: 17.0f];

    switch (indexPath.section) {
        case 0: {
            if (indexPath.row) {
                cell.textLabel.text = @"Astoria";
            }
            else {
                cell.textLabel.text = @"Hotel Europe";
            }
            break;
        }
        case 1:
            if (indexPath.row) {
                cell.textLabel.text = @"Teplo";
            }
            else {
                cell.textLabel.text = @"Ginza";
            }
            break;
        case 2:
            if (indexPath.row) {
                cell.textLabel.text = @"The Russian Museum";
            }
            else {
                cell.textLabel.text = @"Hermitage";
            }
            break;
            
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tintColor = OrangeColor;
    return cell;
}

#pragma mark - MWPhotoBrowser

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create array of MWPhoto objects
    self.photos = [NSMutableArray array];
    
    // Add photos
    /*[self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-1" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-2" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-3" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-4" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-5" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-6" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-7" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-8" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-9" ofType:@"jpg"]]]];
    [self.photos addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"grand-hotel-europe-spb-10" ofType:@"jpg"]]]];
     */
    
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Customise selection images to change colours if required
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:1];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:10];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (MWPhoto*) photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [self.photos objectAtIndex: index];
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    return [self.photos objectAtIndex: index];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: CityPicturesSegueKey]) {
        CityPicturesController *dst = (CityPicturesController*)segue.destinationViewController;
        dst.pictures = self.city.pictures;
    }
}

@end
