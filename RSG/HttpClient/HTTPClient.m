//
//  HTTPClient.m
//  RSG
//
//  Created by Rodion Bychkov on 30.10.15.
//  Copyright © 2015 LetsSee. All rights reserved.
//

#import "HTTPClient.h"
#import "NetworkPaths.h"
#import "City.h"

@implementation HTTPClient

+(instancetype) sharedHTTPClient
{
    static HTTPClient *_sharedHttpClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHttpClient = [[self alloc] initWithBaseURL: [NSURL URLWithString: kServerUrlString]];
        _sharedHttpClient.securityPolicy.allowInvalidCertificates = NO;
    });
    
    return _sharedHttpClient;
}

-(void) getCityList: (void (^)(BOOL success, NSError *error, NSArray *cities))completion  {
    [self GET: kCityList parameters: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass: [NSArray class]]) {
            NSMutableArray *cityArray = [NSMutableArray arrayWithCapacity: [responseObject count]];
            for (id obj in responseObject) {
                City *city = [[City alloc] initWithObj: obj];
                [cityArray addObject: city];
            }
            if (completion) {
                completion (YES, nil, [NSArray arrayWithArray: cityArray]);
            }
        }
        else {
            if (completion) {
                completion (NO, nil, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (completion) {
            completion (NO, error, nil);
        }
    }];
}

@end
