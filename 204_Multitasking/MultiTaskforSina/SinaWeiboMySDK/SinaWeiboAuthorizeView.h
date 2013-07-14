//
//  SinaWeiboAuthorizeView.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SinaWeiboAuthorizeViewDelegate;

@interface SinaWeiboAuthorizeView : UIView <UIWebViewDelegate>
{
    UIWebView *webView;
    UIButton *closeButton;
    UIView *modalBackgroundView;
    UIActivityIndicatorView *indicatorView;
    UIInterfaceOrientation previousOrientation;
    
    NSString *appRedirectURI;
    NSDictionary *authParams;
}

@property (nonatomic, assign) id<SinaWeiboAuthorizeViewDelegate> delegate;

- (id)initWithAuthParams:(NSDictionary *)params
                delegate:(id<SinaWeiboAuthorizeViewDelegate>)delegate;

- (void)show;
- (void)hide;

@end

@protocol SinaWeiboAuthorizeViewDelegate <NSObject>

- (void)authorizeView:(SinaWeiboAuthorizeView *)authView
        didRecieveAuthorizationCode:(NSString *)code;
- (void)authorizeView:(SinaWeiboAuthorizeView *)authView
        didFailWithErrorInfo:(NSDictionary *)errorInfo;
- (void)authorizeViewDidCancel:(SinaWeiboAuthorizeView *)authView;

@end