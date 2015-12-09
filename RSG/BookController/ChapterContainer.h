//
//  ChapterContainer.h
//  RSG
//
//  Created by Rodion Bychkov on 21.11.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChapterContainer : NSObject <NSLayoutManagerDelegate>

@property (nonatomic, retain) NSTextStorage *textStorage;
@property (nonatomic, retain) NSLayoutManager * layoutManager;
@property (nonatomic) NSUInteger pageCount;
@property (nonatomic) NSUInteger pagesBefore;
@property (nonatomic) BOOL isFilled;
@property (nonatomic) CGSize textViewSize;

@property (nonatomic) NSString *title;
@property (nonatomic) NSMutableArray *paragraphs;

- (instancetype) initWithChapter: (NSUInteger) chapterNumber delegate: (id) delegate;
- (void) fillTextContainers: (CGSize) size;

@end
