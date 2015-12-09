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

@interface MatterController ()

@end

@implementation MatterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = L(MattersSegueKey);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(close:)];
    TICK;
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
                        container.title = [[container.textStorage attributedSubstringFromRange: range] string];
                    }
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
    return 65.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView  =[[UIView alloc] initWithFrame: CGRectZero];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(10, 0, 300, 60)];
    [button addTarget: self action: @selector(sectionButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
    [button setTitleColor: DarkGrayColor forState: UIControlStateNormal];
    [button.titleLabel setFont: [UIFont fontWithName: @"IowanOldStyle-Bold" size: 15.0f]];
    [button.titleLabel setNumberOfLines: 3];
    [button.titleLabel setTextAlignment: NSTextAlignmentLeft];
    [button setContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
    [headerView addSubview: button];
    
    ChapterContainer *container = [self.chapterContainers objectAtIndex: section];
    [button setTag: section];
    [button setTitle: container.title forState: UIControlStateNormal];
    
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: MatterCell];
    ChapterContainer *container = [self.chapterContainers objectAtIndex: indexPath.section];
    Paragraph *p = [container.paragraphs objectAtIndex: indexPath.row];
    cell.textLabel.font = [UIFont fontWithName: @"IowanOldStyle-BoldItalic" size: 14.0f];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.text = p.title;
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
