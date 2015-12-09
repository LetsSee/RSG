//
//  Util.h
//  ChildIntra
//
//  Created by Rodion Bychkov on 11.07.14.
//  Copyright (c) 2014 Arcadia. All rights reserved.
//

#ifndef ChildIntra_New_Util_h
#define ChildIntra_New_Util_h

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

#define L(locStrKey)                    NSLocalizedString(locStrKey, nil)

#define RUN_ON_UI_THREAD(block)         if ([NSThread isMainThread]) block(); else dispatch_sync(dispatch_get_main_queue(), block);

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

#endif
