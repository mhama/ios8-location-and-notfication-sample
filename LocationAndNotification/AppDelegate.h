//
//  AppDelegate.h
//  LocationAndNotification
//
//  Created by 浜中 誠 on 2014/07/09.
//  Copyright (c) 2014年 tonchi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate >

@property (strong, nonatomic) UIWindow *window;

- (void)startMonitoringVisits;

@end

