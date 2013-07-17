//
//  DetailViewController.m
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "SettingViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

@interface SettingViewController ()
@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    
    // desc - weibo setup
    if (![SettingViewController sinaweibo]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey
                                                        appSecret:kAppSecret
                                                   appRedirectURI:kAppRedirectURI
                                                      andDelegate:(id<SinaWeiboDelegate>)self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
        if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
        {
            appDelegate.sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
            appDelegate.sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
            appDelegate.sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
        }
    }

//    NSLog(@"%d", [SettingViewController sinaweibo].isLoggedIn);
    self->_enableAuthroizeUISwitch.on = [SettingViewController sinaweibo].isLoggedIn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sina weibo cache

+ (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [SettingViewController sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - uiswitch for logon or logoff

- (void)weiboLogon{
    userInfo = nil;
    statuses = nil;
    
    SinaWeibo *sinaweibo = [SettingViewController sinaweibo];
    [sinaweibo logIn];
}

- (void)weiboLogoff{
    SinaWeibo *sinaweibo = [SettingViewController sinaweibo];
    [sinaweibo logOut];
}

// desc - status validation - status&code
- (IBAction)EnableAuthorize:(id)sender{
    UISwitch* control = (UISwitch*)sender;
    if (control.isOn) {
        [self weiboLogon];
    }
    else{
        [self weiboLogoff];
    }
}

- (void)resetButtons
{
    SinaWeibo *sinaweibo = [SettingViewController sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if (authValid) {
        self->_enableAuthroizeUISwitch.on = YES;
    }
    else{
        self->_enableAuthroizeUISwitch.on = NO;
    }
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self resetButtons];
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    [self resetButtons];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
    //desc - if cancelled, just reset uiswitch
    [self resetButtons];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
    [self resetButtons];
}

@end
