//
//  AppDelegate.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppKey             @"2221754587"
#define kAppSecret          @"6a6f80a0c12e72e838b7950f6c44e421"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;
@class WeiboStatusViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    SinaWeibo *_sinaweibo;
    IBOutlet WeiboStatusViewController *weiboStatusViewController;
}

@property (readwrite, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;

@end
