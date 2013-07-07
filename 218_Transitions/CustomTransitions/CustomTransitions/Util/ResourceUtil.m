//
//  ResourceUtil.m
//  CustomTransitions
//
//  Created by ding orlando on 7/7/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import "ResourceUtil.h"

@implementation ResourceUtil

+ (UIColor*)tableBackgroundImage{
    int _dHeight = (int)[UIScreen mainScreen].bounds.size.height;
    UIColor* imgBackgroundColor = nil;
    if(568 == _dHeight){
        imgBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow-extends.png"]];
    }
    else if(480 == _dHeight){
        imgBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow.png"]];
    }
    else{
        imgBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow.png"]];
    }
    return imgBackgroundColor;
}

+ (UIImageView*)navigateImage{
    int _dHeight = (int)[UIScreen mainScreen].bounds.size.height;
    UIImageView * imageView = nil;
    if(568 == _dHeight){
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-extends.png"]];
    }
    else if(480 == _dHeight){
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    }
    else{
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    }
    return imageView;
}

@end
