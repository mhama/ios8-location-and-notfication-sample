//
//  AppDelegate.m
//  LocationAndNotification
//
//  Created by 浜中 誠 on 2014/07/09.
//  Copyright (c) 2014年 tonchi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.manager = [CLLocationManager new];
    self.manager.delegate = self;
    
    // アクション
    UIMutableUserNotificationAction *tabAction = [UIMutableUserNotificationAction new];
    tabAction.identifier = @"TAB_IDENTIFIER";
    tabAction.title = @"tabする!";
    tabAction.activationMode = UIUserNotificationActivationModeForeground;
    tabAction.destructive = YES;
    tabAction.authenticationRequired = NO;

    UIMutableUserNotificationAction *sleepAction = [UIMutableUserNotificationAction new];
    sleepAction.identifier = @"SLEEP_IDENTIFIER";
    sleepAction.title = @"寝る";
    sleepAction.activationMode = UIUserNotificationActivationModeBackground;
    sleepAction.destructive = NO;
    sleepAction.authenticationRequired = YES;

    UIMutableUserNotificationAction *clipAction = [UIMutableUserNotificationAction new];
    clipAction.identifier = @"CLIP_IDENTIFIER";
    clipAction.title = @"クリップする!";
    clipAction.activationMode = UIUserNotificationActivationModeForeground;
    clipAction.destructive = NO;
    clipAction.authenticationRequired = NO;

    //　カテゴリ
    UIMutableUserNotificationCategory *aCategory = [UIMutableUserNotificationCategory new];
    aCategory.identifier = @"HELLO_CATEGORY";
    [aCategory setActions:@[tabAction, sleepAction] forContext:UIUserNotificationActionContextDefault];

    UIMutableUserNotificationCategory *beaconCategory = [UIMutableUserNotificationCategory new];
    beaconCategory.identifier = @"BEACON_CATEGORY";
    [beaconCategory setActions:@[clipAction] forContext:UIUserNotificationActionContextDefault];

    NSSet *categories = [NSSet setWithObjects:aCategory, beaconCategory, nil];
    
    // 通知設定
    UIUserNotificationType types = UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    return YES;
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    NSDictionary *messages = @{
                              @"SLEEP_IDENTIFIER" :@"寝ました。",
                              @"TAB_IDENTIFIER" : @"tabしました。",
                              @"CLIP_IDENTIFIER" : @"クリップしましょう！"
                              };
    NSString *message = messages[identifier];
    
    NSString *title = @"アクション";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
{
    if (![visit.arrivalDate isEqualToDate:NSDate.distantPast] && ![visit.departureDate isEqualToDate:NSDate.distantFuture]) {
        NSTimeInterval interval = [visit.departureDate timeIntervalSinceDate:visit.arrivalDate];
        if ([visit.arrivalDate isEqualToDate:NSDate.distantPast]) {
            interval = 9999.f;
        }
        [self sendLocalNotification:[NSString stringWithFormat:@"Visit: 出発しました！ %.2f分滞在。", interval/60.f]];
        NSLog(@"/// departure: %@ : %@",[NSDate date], visit);
    } else if (![visit.arrivalDate isEqualToDate:NSDate.distantPast]) {
        [self sendLocalNotification:@"Visit: 訪問しました！"];
        NSLog(@"/// arrival: %@ : %@",[NSDate date],visit);
    }
}

- (void)sendLocalNotification:(NSString *)message
{
    UILocalNotification *notif = [UILocalNotification new];
    notif.alertBody = message;
    notif.soundName = UILocalNotificationDefaultSoundName;
    notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1f];
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
}

- (void)startMonitoringVisits
{
    self.manager.delegate = self;
    [self.manager startMonitoringVisits];
}

@end
