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

-(void) getStatus: (void (^)(BOOL success, NSError *error))completion;
-(void) getCityList: (void (^)(BOOL success, NSError *error, NSArray *cities))completion;
-(void) getItemsListCityID: (NSString *) cityID completion: (void (^)(BOOL success, NSError *error, NSArray *items))completion;

@end
