//
//  CityPicturesController.h
//  RSG
//
//  Created by Rodion Bychkov on 07.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface CityPicturesController : UIViewController <MWPhotoBrowserDelegate>

@property (nonatomic) NSArray *pictures;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
