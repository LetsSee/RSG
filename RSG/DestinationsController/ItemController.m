//
//  ItemController.m
//  RSG
//
//  Created by Rodion Bychkov on 04.02.16.
//  Copyright © 2016 LetsSee. All rights reserved.
//

#import "ItemController.h"
#import "ImageCell.h"
#import "Picture.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface ItemController ()

@end

@implementation ItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.item) {
        self.textView.text = self.item.descriptionText;
    }
    // Do any additional setup after loading the view.
}

/*-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.textView scrollRectToVisible: CGRectMake(0, 0, 1, 1) animated: NO];
}*/

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setItem:(Item *)item {
    _item = item;
    if (item.name.length) {
        self.navigationItem.title = item.name;
    }
    if (item.descriptionText.length) {
        self.textView.text = item.descriptionText;
    }
    [self.collectionView reloadData];
}


#pragma mark - UICollectionView Data Source


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.item.pictures count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(140.0f, 140.0f);
    
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ImageCell";
    
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier forIndexPath: indexPath];
    Picture *p = [self.item.pictures objectAtIndex:indexPath.row];
    //cell.imageView.layer.borderColor = LightGrayColor.CGColor;
    //cell.imageView.layer.borderWidth = 1.0;

    [cell.imageView sd_setImageWithURL: [p thumbURLOfType: self.type.stringValue] placeholderImage: [UIImage imageNamed: @"album_placeholder"]];
    return cell;
}

#pragma mark - UICollectionView Delegate

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate: self];
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    [browser setCurrentPhotoIndex: indexPath.row];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //UIViewController *viewController = [self firstAvailableUIViewController];
    [self presentViewController:nc animated:YES completion:nil];
}


#pragma mark - MWPhotoBrowser

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.item.pictures.count;
}

- (MWPhoto*) photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    Picture *p = [self.item.pictures objectAtIndex: index];
    return [p photoOfType: self.type.stringValue];
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    Picture *p = [self.item.pictures objectAtIndex: index];
    return [p thumbOfType: self.type.stringValue];
}


@end
