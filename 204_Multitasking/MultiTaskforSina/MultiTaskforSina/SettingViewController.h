//
//  DetailViewController.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeiboRequest.h"

@interface SettingViewController : UITableViewController<SinaWeiboRequestDelegate>{
    NSDictionary *userInfo;
    NSArray *statuses;
    IBOutlet UISwitch* _enableAuthroizeUISwitch;
}

/**
 * static for global sharding setting
 **/
+ (SinaWeibo *)sinaweibo;

@end
