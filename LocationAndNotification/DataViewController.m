//
//  DataViewController.m
//  LocationAndNotification
//
//  Created by 浜中 誠 on 2014/07/09.
//  Copyright (c) 2014年 tonchi. All rights reserved.
//

#import "DataViewController.h"
#import "AppDelegate.h"

@import CoreLocation;

@interface DataViewController ()
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation DataViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [CLLocationManager new];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (IBAction)requestLocationWhenInUse:(id)sender {
    [self.manager requestWhenInUseAuthorization];
}

- (IBAction)requestLocationAlways:(id)sender {
    [self.manager requestAlwaysAuthorization];
}

- (IBAction)gotoSettings:(id)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString:UIApplicationOpenSettingsURLString ]];
}

- (IBAction)notify:(id)sender {
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"こんにちはこんにちはこんにちは！";

    notification.fireDate = [NSDate dateWithTimeInterval:5.0f sinceDate:[NSDate date]];
    notification.category = @"HELLO_CATEGORY";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (IBAction)addLocationNotification:(id)sender {
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"近くにビーコン発見！";
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"8f65acd4-072e-11e4-8024-63ee1ec90bcb"]; // ビーコンが発信しているUUIDに置き換えましょう。
    
    notification.region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"tab beacon"];

    notification.category = @"BEACON_CATEGORY";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

}

- (IBAction)startVisitMonitoring:(id)sender {
    [((AppDelegate *) [UIApplication sharedApplication].delegate) startMonitoringVisits];
}


@end
