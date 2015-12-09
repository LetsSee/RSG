//
//  CityPicturesController.m
//  RSG
//
//  Created by Rodion Bychkov on 07.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "CityPicturesController.h"
#import "ImageCell.h"
#import "Picture.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface CityPicturesController ()

@end

@implementation CityPicturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPictures:(NSArray *)pictures {
    _pictures = pictures;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Data Source


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.pictures count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(110.0f, 110.0f);

}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ImageCell";
    
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier forIndexPath: indexPath];
    Picture *p = [self.pictures objectAtIndex:indexPath.row];
    //cell.imageView.layer.borderColor = LightGrayColor.CGColor;
    //cell.imageView.layer.borderWidth = 1.0;

    [cell.imageView sd_setImageWithURL: [p url] placeholderImage: [UIImage imageNamed: @"album_placeholder"]];
    return cell;
}

#pragma mark - UICollectionView Delegate

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/*- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Child *child = [self.childrenList objectAtIndex:indexPath.row];
    
    [self performSelector: @selector(goToChildControllerWithChild:) withObject: child afterDelay: 0.0];
    [collectionView deselectItemAtIndexPath: indexPath animated: YES];
    
}*/

@end
