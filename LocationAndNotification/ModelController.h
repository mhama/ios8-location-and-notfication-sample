//
//  ModelController.h
//  LocationAndNotification
//
//  Created by 浜中 誠 on 2014/07/09.
//  Copyright (c) 2014年 tonchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

