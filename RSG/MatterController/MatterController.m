//
//  MatterController.m
//  RSG
//
//  Created by Rodion Bychkov on 15.09.15.
//  Copyright (c) 2015 LetsSee. All rights reserved.
//

#import "MatterController.h"
#import "ChapterContainer.h"
#import "Paragraph.h"
#import "NSString+RomanNumerals.h"
#import "NSString+Common.h"
#import "HeaderView.h"

@interface MatterController ()

@end

@implementation MatterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib: [UINib nibWithNibName: @"HeaderView" bundle: nil]  forHeaderFooterViewReuseIdentifier: @"TableSectionHeader"];
    
    self.navigationItem.title = L(MattersSegueKey);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(close:)];
    TICK;
    if (self.chapterContainers.count > 1) {
        for (ChapterContainer *container in self.chapterContainers) {
            container.paragraphs = [NSMutableArray array];
            [container.textStorage enumerateAttribute: NSFontAttributeName inRange:NSMakeRange(0, container.textStorage.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
                if (value) {
                    UIFont *font = value;
                    if ([font.fontName isEqualToString: @"IowanOldStyle-BoldItalic"]) {
                        
                        NSUInteger pageNumber = 0;
                        
                        for (NSTextContainer *tc in container.layoutManager.textContainers) {
                            NSRange tcRange = [container.layoutManager glyphRangeForTextContainer: tc];
                            if (NSIntersectionRange(tcRange, range).length) {
                                pageNumber = [container.layoutManager.textContainers indexOfObject: tc];
                                break;
                            }
                        }
                        Paragraph *p = [[Paragraph alloc] initWithTitle: [[container.textStorage attributedSubstringFromRange: range] string] pageNumber: pageNumber];
                        [container.paragraphs addObject: p];
                    }
                    else {
                        if ([font.fontName isEqualToString: @"IowanOldStyle-Bold"]) {
                            NSString *tmp = [[container.textStorage attributedSubstringFromRange: range] string];
                            NSArray *comps = [tmp componentsSeparatedByString: @"\n"];
                            if ([comps.firstObject hasPrefix: @"Chapter"]) {
                                container.title = [comps objectAtIndex: 1];
                            }
                            else {
                                container.title = [comps objectAtIndex: 0];
                            }
                            
                        }
                    }
                }
            }];
            
        }
    }
    else {
        ChapterContainer *container = self.chapterContainers.lastObject;
        container.paragraphs = [NSMutableArray array];
        [container.textStorage enumerateAttribute: NSFontAttributeName inRange:NSMakeRange(0, container.textStorage.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (value) {
                UIFont *font = value;
                if ([font.fontName isEqualToString: @"IowanOldStyle-Bold"]) {
                    
                    NSUInteger pageNumber = 0;
                    
                    for (NSTextContainer *tc in container.layoutManager.textContainers) {
                        NSRange tcRange = [container.layoutManager glyphRangeForTextContainer: tc];
                        if (NSIntersectionRange(tcRange, range).length) {
                            pageNumber = [container.layoutManager.textContainers indexOfObject: tc];
                            break;
                        }
                    }
                    Paragraph *p = [[Paragraph alloc] initWithTitle: [[container.textStorage attributedSubstringFromRange: range] string] pageNumber: pageNumber];
                    [container.paragraphs addObject: p];
                }
            }
        }];
    }

    TOCK;
    [self.tableView reloadData];
}

-(void) close: (id) sender {
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chapterContainers.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ChapterContainer *container = [self.chapterContainers objectAtIndex: section];
    return container.paragraphs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    UIFont *f = [UIFont fontWithName: @"IowanOldStyle-Bold" size: 17.0f];
    ChapterContainer *container = [self.chapterContainers objectAtIndex: section];
    
    NSString *sectionTitle = nil;
    if (section) {
        NSString *n = [NSString romanNumeral: section];
        sectionTitle = [NSString stringWithFormat: @"%@. %@", n, container.title];
    }
    else {
        sectionTitle = container.title;
    }
    
    CGFloat textHeight = [sectionTitle textHeightForWidth: (self.view.bounds.size.width-30.0f) andFont: f];
    return textHeight + 16.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ChapterContainer *container = [self.chapterContainers objectAtIndex: section];
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: @"TableSectionHeader"];
    [headerView.button addTarget: self action: @selector(sectionButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
    [headerView.button setTag: section];
    
    NSString *sectionTitle = nil;
    if (section) {
        NSString *n = [NSString romanNumeral: section];
        sectionTitle = [NSString stringWithFormat: @"%@. %@", n, container.title];
    }
    else {
        sectionTitle = container.title;
    }
    
    [headerView.button setTitle: sectionTitle forState: UIControlStateNormal];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *f = [UIFont fontWithName: @"IowanOldStyle-Roman" size: 16.0f];
    ChapterContainer *container = [self.chapterContainers objectAtIndex: indexPath.section];
    Paragraph *p = [container.paragraphs objectAtIndex: indexPath.row];
    return ([p.title textHeightForWidth: self.view.bounds.size.width - 44.0f andFont: f]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: MatterCell];
    ChapterContainer *container = [self.chapterContainers objectAtIndex: indexPath.section];
    Paragraph *p = [container.paragraphs objectAtIndex: indexPath.row];
    cell.textLabel.font = [UIFont fontWithName: @"IowanOldStyle-Roman" size: 16.0f];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = p.title;
    cell.separatorInset = UIEdgeInsetsMake(0.0f, 30.0f, 0.0f, 0.0f);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    if (self.delegate) {
        ChapterContainer *container = [self.chapterContainers objectAtIndex: indexPath.section];
        Paragraph *p = [container.paragraphs objectAtIndex: indexPath.row];
        //[self.delegate selectChapterAtIndex: indexPath.section];
        [self.delegate selectParagraph: p.pageNumber chapterIndex: indexPath.section];
    }
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(void) sectionButtonTapped: (id) sender {
    if (self.delegate) {
        [self.delegate selectChapterAtIndex: [sender tag]];
    }
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
