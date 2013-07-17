//
//  NSObject+SinaWeibo.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/17/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeiboRequest.h"

@class SinaWeibo;
@protocol SinaWeiboStatusDelegate;

@interface SinaWeibo (Status)

- (NSArray*)doStatusRequest;
- (void)sinaweiboGetLatestStatuses:(id<SinaWeiboRequestDelegate>) vcdelegate;

@end

@protocol SinaWeiboStatusDelegate <NSObject>

@optional

- (void)sinaweiboDidgetLatestStatuses:(SinaWeibo *)sinaweibo;

@end
