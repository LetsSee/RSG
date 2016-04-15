//
//  ChapterContainer.m
//  RSG
//
//  Created by Rodion Bychkov on 21.11.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "ChapterContainer.h"
#define kHorizontalInset (8.0f+8.0f)
#define kVerticalInset (8.0f+3.0f+31.0f+3.0f+17.0f+8.0f)

@implementation ChapterContainer

- (instancetype) initWithChapter: (NSUInteger) chapterNumber delegate: (id) delegate
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        NSURL *htmlString = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat: @"ch%lu", (unsigned long)chapterNumber] withExtension:@"html"];
        NSAttributedString *string = [[NSAttributedString alloc] initWithFileURL: htmlString
                                                                         options: @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                              documentAttributes: nil
                                                                           error: &error];
        if (error) {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle: @"Error"
                                                  message: @"Unable to parse chapter one"
                                                  preferredStyle: UIAlertControllerStyleAlert];
            [delegate presentViewController:alertController animated:YES completion: ^{
                [self performSelector: @selector(dismissAlertController:) withObject: alertController afterDelay: 1.5];
            }];
        }
        
        self.textStorage = [[NSTextStorage alloc] initWithAttributedString: string];
        self.layoutManager = [[NSLayoutManager alloc] init];
        self.layoutManager.allowsNonContiguousLayout = YES;
        self.layoutManager.delegate = self;
        [self.layoutManager setTextStorage: self.textStorage];
        
        string = nil;
    }
    return self;
}

- (instancetype) initWithChapterName: (NSString *) name delegate: (id) delegate
{
    self = [super init];
    if (self) {
        NSError *error = nil;
        NSURL *htmlString = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat: @"%@", name] withExtension:@"html"];
        NSAttributedString *string = [[NSAttributedString alloc] initWithFileURL: htmlString
                                                                         options: @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                              documentAttributes: nil
                                                                           error: &error];
        if (error) {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle: @"Error"
                                                  message: @"Unable to parse chapter one"
                                                  preferredStyle: UIAlertControllerStyleAlert];
            [delegate presentViewController:alertController animated:YES completion: ^{
                [self performSelector: @selector(dismissAlertController:) withObject: alertController afterDelay: 1.5];
            }];
        }
        
        self.textStorage = [[NSTextStorage alloc] initWithAttributedString: string];
        self.layoutManager = [[NSLayoutManager alloc] init];
        self.layoutManager.allowsNonContiguousLayout = YES;
        self.layoutManager.delegate = self;
        [self.layoutManager setTextStorage: self.textStorage];
        
        string = nil;
    }
    return self;
}

- (BOOL)needsMorePages{
    if (self.layoutManager.textContainers.count == 0)
        return YES;
    
    NSRange range = [self.layoutManager glyphRangeForTextContainer:[self.layoutManager.textContainers lastObject]];
    NSUInteger glyphs = [self.layoutManager numberOfGlyphs];
    
    return range.location + range.length < glyphs;
}


-(void) fillTextContainers: (CGSize) size {
    self.textViewSize = CGSizeMake(size.width - kHorizontalInset, size.height-kVerticalInset);
    TICK;
    NSUInteger i = 0;
    while ([self needsMorePages]) {
        NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize: self.textViewSize];
        textContainer.widthTracksTextView = NO;
        textContainer.heightTracksTextView = NO;
        [self.layoutManager addTextContainer: textContainer];
        i++;
    }
    self.pageCount = i;
    TOCK;
    self.isFilled = YES;
}


-(void) dismissAlertController: (UIAlertController *) ac {
    [ac dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark - LayoutManager Delegate


- (void)layoutManager:(NSLayoutManager *)layoutManager textContainer:(NSTextContainer *)textContainer didChangeGeometryFromSize:(CGSize)oldSize {
    textContainer.size = self.textViewSize;
}

-(void) dealloc {
    self.layoutManager.textStorage = nil;
    self.layoutManager.delegate = nil;
}

@end
