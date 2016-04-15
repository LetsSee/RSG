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
#import "Item.h"

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

-(void) getStatus: (void (^)(BOOL success, NSError *error))completion  {
    [self GET: kStatusPath parameters: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (completion) {
            completion (YES, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (completion) {
            completion (NO, error);
        }
    }];
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

-(void) getItemsListCityID: (NSString *) cityID completion: (void (^)(BOOL success, NSError *error, NSArray *items))completion  {
    NSString * str = [NSString stringWithFormat: kItemList, cityID];
    [self GET: str parameters: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass: [NSArray class]]) {
            NSMutableArray *itemsArray = [NSMutableArray arrayWithCapacity: [responseObject count]];
            for (id obj in responseObject) {
                Item *item = [[Item alloc] initWithObj: obj];
                [itemsArray addObject: item];
            }
            if (completion) {
                completion (YES, nil, [NSArray arrayWithArray: itemsArray]);
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
