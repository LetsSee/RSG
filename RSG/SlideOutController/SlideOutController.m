//
//  CNSlideOutController.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 14.05.14.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "SlideOutController.h"
#import "NavigationCell.h"

@interface CNSlideOutController () {
    NSArray *firstSectionRows;
    NSArray *secondSectionRows;
}

@end


@implementation CNSlideOutController

-(void) awakeFromNib {
    [super awakeFromNib];
    
    self->firstSectionRows = @[BookSegueKey];
    self->secondSectionRows = @[DestinationsSegueKey, ProsSegueKey, TouristsSegueKey, FactsSegueKey, AuthorsSegueKey];
    
    self->tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(onSlide)];
    
    self->swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(onSlide)];
    [self->swipeGesture setDirection: UISwipeGestureRecognizerDirectionLeft];

    self->swipeOutGesture = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(onSlide)];
    [self->swipeOutGesture setDirection: UISwipeGestureRecognizerDirectionRight];
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(onSlide) name: SlideOutNotificationKey object: nil];
    
    [super viewDidLoad];
    
    self.navigationTableView.scrollsToTop = NO;
    
    self.view.backgroundColor = DarkGrayColor;
    self.navigationTableView.backgroundColor = DarkGrayColor;
    self.navigationTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.navigationTableView.separatorColor = BlackColor;
    self.navigationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self.containerView addGestureRecognizer: self->swipeOutGesture];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (!self->selectedIndexPath) {
        [self.navigationTableView selectRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 2] animated: NO scrollPosition: UITableViewScrollPositionNone];
        self->selectedIndexPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableView Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section)
        return 1;
    else
        return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.tintColor = OrangeColor;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) {
        return self->secondSectionRows.count;
    }
    else
        return self->firstSectionRows.count;
}


-(void) configureNavigationCell:(NavigationCell*) cell forIndexPath: (NSIndexPath *) indexPath {
    NSString *stringId = nil;
    if (indexPath.section) {
        stringId = [self->secondSectionRows objectAtIndex: indexPath.row];
    }
    else {
        stringId = [self->firstSectionRows objectAtIndex: indexPath.row];
    }

    UIImage *icon = nil;
    
    SWITCH(stringId) {
        CASE(BookSegueKey) {
            icon = [UIImage imageNamed: @"book"];
            break;
        }
        CASE(DestinationsSegueKey) {
            icon = [UIImage imageNamed: @"destinations"];
            break;
        }
        CASE(ProsSegueKey) {
            icon = [UIImage imageNamed: @"tips"];
            break;
        }
        CASE(TouristsSegueKey) {
            icon = [UIImage imageNamed: @"tips"];
            break;
        }
        CASE(FactsSegueKey) {
            icon = [UIImage imageNamed: @"interesting-facts"];
            break;
        }
        CASE(AuthorsSegueKey) {
            icon = [UIImage imageNamed: @"about-authors"];
            break;
        }
        DEFAULT {
            break;
        }
    }
    cell.textLabel.text = L(stringId);
    cell.imageView.image = icon;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *navIdentifier = @"NavigationCell";
    NavigationCell *cell = (NavigationCell*)[tableView dequeueReusableCellWithIdentifier: navIdentifier];
    [self configureNavigationCell: cell forIndexPath: indexPath];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return MediumRowHeight;
    }
    else {
        return StandartRowHeight;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self->selectedIndexPath = indexPath;
    if (indexPath.section)
        [self.contentController showControllerWithStoryboardId: [self->secondSectionRows objectAtIndex: indexPath.row]];
    else
        [self.contentController showControllerWithStoryboardId: [self->firstSectionRows objectAtIndex: indexPath.row]];

    [self onSlide];

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ContentSegue"]) {
        self.contentController = (ContentController *) [segue destinationViewController];
    }
}


#pragma mark notifications

-(void) onSlide {

    [self.containerView removeGestureRecognizer: self->tapGesture];
    [self.containerView removeGestureRecognizer: self->swipeGesture];
    [self.containerView removeGestureRecognizer: self->swipeOutGesture];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration: 0.3 animations: ^{
        
        if (self.leadingSpaceConstraint.constant) {
            self.leadingSpaceConstraint.constant = 0;
            [self.containerView addGestureRecognizer: self->swipeOutGesture];
            
        }
        else {
            self.leadingSpaceConstraint.constant = SlideOutOffset;
            [self.containerView addGestureRecognizer: self->tapGesture];
            [self.containerView addGestureRecognizer: self->swipeGesture];
        }
        [self.view layoutIfNeeded];
        
    }];
}

-(void) setToOriginalState {
    [self.containerView removeGestureRecognizer: self->tapGesture];
    [self.containerView removeGestureRecognizer: self->swipeGesture];
    [self.containerView removeGestureRecognizer: self->swipeOutGesture];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration: 0.3 animations: ^{

        self.leadingSpaceConstraint.constant = 0;
        [self.containerView addGestureRecognizer: self->swipeOutGesture];
        [self.view layoutIfNeeded];
        
    }];
}


@end
