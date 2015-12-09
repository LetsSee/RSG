//
//  HTTPClient.h
//  RSG
//
//  Created by Rodion Bychkov on 30.10.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HTTPClient : AFHTTPSessionManager

+ (instancetype) sharedHTTPClient;

-(void) getCityList: (void (^)(BOOL success, NSError *error, NSArray *cities))completion;

@end
