// AFHTTPRequestLogger.h
//
// Copyright (c) 2011 AFNetworking (http://afnetworking.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFHTTPRequestOperationLogger.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLSessionManager.h"
#import <objc/runtime.h>

@implementation AFHTTPRequestOperationLogger

+ (instancetype)sharedLogger {
    static AFHTTPRequestOperationLogger *_sharedLogger = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLogger = [[self alloc] init];
    });
    
    return _sharedLogger;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.level = AFLoggerLevelInfo;
    
    return self;
}

- (void)startLogging {
    NSLog(@"Logger initialized");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HTTPOperationDidStart:) name:AFNetworkingOperationDidStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HTTPOperationDidFinish:) name:AFNetworkingOperationDidFinishNotification object:nil];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HTTPOperationDidStart:) name:AFNetworkingTaskDidResumeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HTTPOperationDidFinish:) name:AFNetworkingTaskDidSuspendNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HTTPOperationDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
#endif
}

#pragma mark - NSNotification

static void * AFHTTPRequestOperationStartDate = &AFHTTPRequestOperationStartDate;

- (void)HTTPOperationDidStart:(NSNotification *)notification {
    id operation = [notification object];
    
    if (!([operation isKindOfClass:[AFHTTPRequestOperation class]] || [operation isKindOfClass: [NSURLSessionDataTask class]])) {
        return;
    }
    
    objc_setAssociatedObject(operation, AFHTTPRequestOperationStartDate, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.filterPredicate && [self.filterPredicate evaluateWithObject:operation]) {
        return;
    }
    
    NSString *body = nil;
    NSString *httpMethod = nil;
    NSString *url = nil;
    NSString *headerFields = nil;
    
    if ([operation isKindOfClass:[AFHTTPRequestOperation class]]) {
        AFHTTPRequestOperation *op = operation;
        if ([op.request HTTPBody]) {
            body = [[NSString alloc] initWithData:[op.request HTTPBody] encoding:NSUTF8StringEncoding];
        }
        httpMethod = [op.request HTTPMethod];
        url = [[op.request URL] absoluteString];
        headerFields =  [[op.request allHTTPHeaderFields] description];
    }
    
    
    if ([operation isKindOfClass: [NSURLSessionDataTask class]]) {
        NSURLSessionTask *op = operation;
        if ([op.currentRequest HTTPBody]) {
            body = [[NSString alloc] initWithData:[op.currentRequest HTTPBody] encoding:NSUTF8StringEncoding];
        }
        httpMethod = [op.currentRequest HTTPMethod];
        url = [[op.currentRequest URL] absoluteString];
        headerFields =  [[op.currentRequest allHTTPHeaderFields] description];

    }

    
    switch (self.level) {
        case AFLoggerLevelDebug:
            NSLog(@"Request started[%@ '%@': %@ %@]\n", httpMethod, url, headerFields, body);
            break;
        case AFLoggerLevelInfo:
            NSLog(@"Request started[%@ '%@']\n", httpMethod, url);
            break;
        default:
            break;
    }
}

- (void)HTTPOperationDidFinish:(NSNotification *)notification {
     id operation = [notification object];
    
    if (!([operation isKindOfClass:[AFHTTPRequestOperation class]] || [operation isKindOfClass: [NSURLSessionDataTask class]])) {
        return;
    }
    
    if (self.filterPredicate && [self.filterPredicate evaluateWithObject:operation]) {
        return;
    }
    
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(operation, AFHTTPRequestOperationStartDate)];
    
    NSError *error = nil;
    NSString *httpMethod = nil;
    NSString *url = nil;
    NSString *headerFields = nil;
    NSUInteger status = 0;
    
    if ([operation isKindOfClass:[AFHTTPRequestOperation class]]) {
        AFHTTPRequestOperation *op = operation;
        httpMethod = [op.request HTTPMethod];
        url = [[op.request URL] absoluteString];
        headerFields =  [[op.request allHTTPHeaderFields] description];
        error = op.error;
        status = [op.response statusCode];
    }
    
    
    if ([operation isKindOfClass: [NSURLSessionDataTask class]]) {
        NSURLSessionTask *op = operation;
        httpMethod = [op.currentRequest HTTPMethod];
        url = [[op.currentRequest URL] absoluteString];
        headerFields =  [[op.currentRequest allHTTPHeaderFields] description];
        error = op.error;
        status = op.state;
    }
    
    
    
    if (error) {
        switch (self.level) {
            case AFLoggerLevelDebug:
            case AFLoggerLevelInfo:
                NSLog(@"[Error] %@ '%@' (%ld) [%.04f s]: %@", httpMethod, url, (long)status, elapsedTime, error);
            default:
                break;
        }
    } else {
        switch (self.level) {
            case AFLoggerLevelDebug:
                NSLog(@"Request finished[status: %ld url:'%@' time:[%.04f s]  fields:%@]\n", (long)status, url, elapsedTime, headerFields);
                break;
            case AFLoggerLevelInfo:
                NSLog(@"Request finished[status:%ld url:'%@' time:[%.04f s]]\n", (long)status, url, elapsedTime);
                break;
            default:
                break;
        }
    }
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
#ifdef DEBUG
    NSLog(@"%@ deallocated", NSStringFromClass([self class]));
#endif
}


@end
