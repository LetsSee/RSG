//
//  Picture.h
//  RSG
//
//  Created by Rodion Bychkov on 04.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

@property (nonatomic) NSString *pictureID;

- (instancetype)initWithObj: (id) obj;
-(NSURL *) url;

@end
