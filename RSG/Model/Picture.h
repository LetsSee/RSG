//
//  Picture.h
//  RSG
//
//  Created by Rodion Bychkov on 04.12.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWphoto.h"

@interface Picture : NSObject

@property (nonatomic) NSString *pictureID;

- (instancetype)initWithObj: (id) obj;
-(NSURL *) cityThumbUrl;

-(MWPhoto *) cityThumb;
-(MWPhoto *) cityPhoto;

-(NSURL *) thumbURLOfType: (NSString *) type;
-(MWPhoto *) thumbOfType: (NSString *) type;
-(MWPhoto *) photoOfType: (NSString *) type;

@end
