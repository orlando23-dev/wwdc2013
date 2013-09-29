//
//  ModelController.h
//  EnhanceScrollViewiOS7
//
//  Created by Ding Orlando on 9/29/13.
//  Copyright (c) 2013 Ding Orlando. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
