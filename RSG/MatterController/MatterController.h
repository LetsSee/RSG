//
//  MatterController.h
//  RSG
//
//  Created by Rodion Bychkov on 15.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MatterControllerDelegate <NSObject>

-(void) selectChapterAtIndex: (NSUInteger) index;
-(void) selectParagraph: (NSUInteger) pageNumber chapterIndex: (NSUInteger) index;

@end

@interface MatterController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *chapterContainers;
@property (nonatomic, weak) id <MatterControllerDelegate> delegate;

@end
