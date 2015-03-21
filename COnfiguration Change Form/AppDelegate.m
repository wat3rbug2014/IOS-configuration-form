//
//  AppDelegate.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AppDelegate.h"
#import "TabOverViewController.h"
#import "UIColor+ExtendedColor.h"
#import "AddDeviceController.h"
#import "RemoveDeviceController.h"
#import "AlterDeviceController.h"
#import "SettingsController.h"
#import"ReplaceDeviceController.h"
#import "BasicDeviceData.h"
#import <CoreLocation/CoreLocation.h>
#import "enumList.h"
#import "Centers.h"

@implementation AppDelegate


@synthesize location;
@synthesize locationManager;
@synthesize locationUpdatesAllowed;
@synthesize locationNames;
@synthesize centerInfo;

enum selectedView {
    NOT_SET,
    ADD_DEVICE,
    REMOVE_DEVICE,
    CHANGE_DEVICE,
    REPLACE_DEVICE,
    SETTINGS
};


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // setup tabview controller
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    TabOverViewController *mainController = [[TabOverViewController alloc] init];
    
    if ([defaults integerForKey:@"ConfigChanger.Mode"] == NOT_SET) {
        [defaults setInteger:ADD_DEVICE forKey:@"ConfigChanger.Mode"];
        [defaults synchronize];
        defaults = nil;
        BasicDeviceData *defaultData = [[BasicDeviceData alloc] init];
        [defaultData addEmailAddress:@"jsc-dl-nics-network-moves@mail.nasa.gov" withName:@"jsc-dl-nics-network-moves"];
        [defaultData updateStoredEmailSettings];
    } else {
        [mainController setSelectedIndex:[defaults integerForKey:@"ConfigChanger.Mode"] - 1];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = mainController;
    [self.window makeKeyAndVisible];

    [[UINavigationBar appearance] setBarTintColor:[UIColor textColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor textColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor navigatorItemColor]];
    
    // setup location manager
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    locationUpdatesAllowed = NO;
    centerInfo = [[Centers alloc] init];
    [self setupLocationMonitoring];
    
    // allow notification badges
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
            settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [self removeRegionsFromMonitoring:[centerInfo centerRegions]];
}

#pragma mark - CoreLocationManagerDelegate Methods


-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Something failed to update for location services");
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {

    NSLog(@"Entered region %@", [region identifier]);
    [self updateIndexForFoundRegion:region];
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground ||
        [[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive) {
        [self presentNotificationForCenter: [centerInfo getNameForRegion:region]];
    }
}

-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    NSLog(@"Left region %@", [region identifier]);
}

-(void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    
    NSLog(@"Now monitoring %@", [region identifier]);
}

-(void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    NSString *foundLocation;
    for (int i = 0; i < [locationNames count]; i++) {
        if ([[region identifier] rangeOfString:[locationNames objectAtIndex:i]].location != NSNotFound && state == CLRegionStateInside) {
            NSLog(@"Found %@", [region identifier]);
            foundLocation = [region identifier];
        }
    }
    NSString *result;
    switch (state) {
        case CLRegionStateInside: {
            result = @"INSIDE";
            [self updateIndexForFoundRegion:region];
            NSString *message = [centerInfo getNameForRegion:region];
            [self presentNotificationForCenter: message];
            break;
        }
        case CLRegionStateOutside: {
            result = @"OUTSIDE";
            break;
        }
        default: {
            result = @"UNKNOWN";
            break;
        }
    }
    NSLog(@"The %@ is %@", [region identifier], result);
}

-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        NSLog(@"NOT authorized");
        locationUpdatesAllowed = NO;
    } else {
        NSLog(@"Authorized");
        locationUpdatesAllowed = YES;
    }
}

#pragma mark - Helper methods


-(void) setupLocationMonitoring {
    
    // check to see if location updating is allowed and region tests can be done
    
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
    }
    [locationManager requestAlwaysAuthorization];
    if (!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        locationUpdatesAllowed = NO;
        NSLog(@"failed to authorize location updates");
        return;
    }
    NSLog(@"Continuing location updating..AUTHORIZED");
    if (![CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        NSLog(@"Region monitored NOT allowed");
        locationUpdatesAllowed = NO;
        return;
    } else {
        NSLog(@"Region monitoring ALLOWED");
    }
    // Add regions to be monitored
    
    NSLog(@"Initial regions count: %lu", (unsigned long)[[locationManager monitoredRegions] count]);
    [self removeRegionsFromMonitoring:[locationManager monitoredRegions]];
    
    NSLog(@"Cleared regions count: %lu", (unsigned long)[[locationManager monitoredRegions] count]);
    [self addRegionsToMonitor:[centerInfo centerRegions]];
    NSLog(@"The app regions monitored is %lu", (unsigned long)[[locationManager monitoredRegions] count]);
}

-(void) removeRegionsFromMonitoring:(NSSet *)regions {
    
    for (CLRegion *currentRegion in regions) {
        [locationManager stopMonitoringForRegion:currentRegion];
    }
}

-(void) addRegionsToMonitor:(NSSet *)regions {
    
    for (CLRegion *currentRegion in regions) {
        [locationManager startMonitoringForRegion: currentRegion];
//        [locationManager requestStateForRegion:currentRegion];
    }
}

-(void) updateIndexForFoundRegion: (CLRegion*) region {
 
    location = (int)[centerInfo getIndexForRegion:region];
}

-(void) presentNotificationForCenter: (NSString*) message {
    
    UILocalNotification *foundNotification = [[UILocalNotification alloc] init];
    [foundNotification setAlertBody:message];
    [foundNotification setSoundName:UILocalNotificationDefaultSoundName];
    [[UIApplication sharedApplication] presentLocalNotificationNow:foundNotification];
}
@end


