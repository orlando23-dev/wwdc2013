//
//  WeiboItemCell.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/21/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* content;
@property (nonatomic, strong) IBOutlet UILabel* userId;
@property (nonatomic, strong) IBOutlet UILabel* createAt;
@property (nonatomic, strong) IBOutlet UIImageView* userIcon;

@end
