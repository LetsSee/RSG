//
//  NSString+Common.h
//  ChildIntra
//
//  Created by Olga Kulish on 23/07/14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

+(BOOL)isEmpty:(NSString *)string;

- (NSString *)stringByTrimming;

- (NSDate *) dateSystem;
- (NSDate *) dateRegularFull;
- (NSDate *) dateRegular;
- (NSDate *) dateSpecial;
- (NSDate *) timeRegular;


- (NSDate *) dateWithFormat:(NSString *)format;
-(CGFloat) textHeightForWidth: (CGFloat) width andFont : (UIFont*) font maxHeight: (CGFloat) maxHeight;
- (CGFloat) textHeightForWidth: (CGFloat) width andFont : (UIFont*) font;
+ (NSString *) stringHumanFileSize:(int64_t)sizeBytes;

+(NSString *)defaultStartTime;
+(NSString *)defaultEndTime;

@end
