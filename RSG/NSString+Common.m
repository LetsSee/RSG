//
//  NSString+Common.m
//  ChildIntra
//
//  Created by Olga Kulish on 23/07/14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

NSString * const bFormat = @"%lld B";
NSString * const kbFormat = @"%1.1f KB";
NSString * const mbFormat = @"%1.1f MB";

+(BOOL)isEmpty:(NSString *)string {    
    return !string || [string isEqualToString:@""]; //trim???
}

- (NSString *)stringByTrimming
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:whitespace];
}

-(NSLocale *) posixLocale {
    static NSLocale *s_enUSPOSIXLocale = nil;
    if (s_enUSPOSIXLocale == nil) {
        s_enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    return s_enUSPOSIXLocale;
}

-(NSDateFormatter *) dateFormatter {
    static NSDateFormatter *s_dateFormatter = nil;
    
    if (s_dateFormatter == nil) {
        s_dateFormatter = [[NSDateFormatter alloc] init];
        [s_dateFormatter setLocale: [self posixLocale]];
        [s_dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    return s_dateFormatter;
}

-(NSDateFormatter *) timeFormatter {
    static NSDateFormatter *s_timeFormatter = nil;
    
    if (s_timeFormatter == nil) {
        s_timeFormatter = [[NSDateFormatter alloc] init];
        [s_timeFormatter setLocale: [self posixLocale]];
        [s_timeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    return s_timeFormatter;
}

-(NSDate *) makeDateFromSelfWithFormat: (NSString *) format {
    NSDateFormatter *df = [self dateFormatter];
    [df setDateFormat: format];
    return [df dateFromString: self];
}

-(NSDate *) makeTimeFromSelfWithFormat: (NSString *) format {
    NSDateFormatter *tf = [self timeFormatter];
    [tf setDateFormat: format];
    return [tf dateFromString: self];
}

- (NSDate *) dateSystem
{
    return [self makeDateFromSelfWithFormat: @"yyyy-MM-dd'T'HH:mm:ss'Z'"];
}

- (NSDate *) dateRegularFull
{
    return [self makeDateFromSelfWithFormat: @"dd-MMMM-yyyy"];
}

- (NSDate *) dateRegular
{
    return [self makeDateFromSelfWithFormat: @"dd MMM yyyy"];
}

- (NSDate *) dateSpecial
{
    return [self makeDateFromSelfWithFormat: @"yyyy-MM-dd"];
}


- (NSDate *) dateWithFormat:(NSString *)format
{
    return [self makeDateFromSelfWithFormat: format];
}

- (NSDate *) timeRegular
{
    return [self makeTimeFromSelfWithFormat: @"HH:mm"];
}

-(CGFloat) textHeightForWidth: (CGFloat) width andFont : (UIFont*) font {
    NSStringDrawingContext *context     = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 0.0;
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: [mutableParagraphStyle copy]};
    
    CGFloat extraSpace = 0.0f;
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width-extraSpace, CGFLOAT_MAX)
                                             options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                          attributes: attributes context: context];
    return ceil(textRect.size.height);

}

-(CGFloat) textHeightForWidth: (CGFloat) width andFont : (UIFont*) font maxHeight: (CGFloat) maxHeight{
    CGFloat height = [self textHeightForWidth: width andFont: font];
    if(maxHeight && height > maxHeight) {
        return maxHeight;
    }
    return height;
}


+ (NSString *) stringHumanFileSize:(int64_t)sizeBytes {
    int64_t threshold = 1024;
    if (sizeBytes < threshold) {
        return [NSString stringWithFormat:bFormat, sizeBytes];
    }
    else if (sizeBytes < threshold*threshold) {
        return [NSString stringWithFormat:kbFormat, (float)sizeBytes/threshold];
    }
    else {
        return [NSString stringWithFormat:mbFormat, (float)sizeBytes/(threshold*threshold)];
    }
}

+(NSString *)defaultStartTime {
    return @"6:30";
}

+(NSString *)defaultEndTime {
    return @"17:00";
}

@end

