//
//  Paragraph.h
//  RSG
//
//  Created by Rodion Bychkov on 02.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paragraph : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSUInteger pageNumber;

- (instancetype)initWithTitle: (NSString *) title pageNumber: (NSUInteger) pageNumber;

@end
