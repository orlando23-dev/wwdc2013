//
//  NavigatedTransitionController.h
//  CustomTransitions
//
//  Created by ding orlando on 7/4/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    slide,
    dump
} NavigatedCategory;

@interface NavigatedTransitionController : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, readwrite) NavigatedCategory navTag;

@end
