//
//  ItemController.h
//  RSG
//
//  Created by Rodion Bychkov on 04.02.16.
//  Copyright © 2016 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "Item.h"

@interface ItemController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic) Item *item;
@property (nonatomic) NSNumber *type;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
