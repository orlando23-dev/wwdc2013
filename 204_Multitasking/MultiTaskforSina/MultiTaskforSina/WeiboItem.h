//
//  WeiboItem.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/17/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboItem : NSObject

@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString* imageURL;
//@property (nonatomic, strong) UIImage* image;

@end
