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

@implementation AppDelegate

@synthesize lastViewController;
@synthesize location;
@synthesize locationManager;
@synthesize locationUpdatesAllowed;
@synthesize locationNames;
@synthesize previousRegions;
@synthesize appRegions;

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
    appRegions = [self createAppRegions];
    [self setupLocationMonitoring];
    
    // setup notification to update view index
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateIndexOfLastViewController:) name:@"CurrentViewController" object:nil];
    
    // allow notification badges
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
            settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    UILocalNotification *batteryNotification = [[UILocalNotification alloc] init];
    [batteryNotification setSoundName:UILocalNotificationDefaultSoundName];
    [batteryNotification setApplicationIconBadgeNumber:1];
//    [batteryNotification setAlertBody:[NSString stringWithFormat:@"%@ has low battery", name]];
//    if (!lowBatteryNotified) {
//        [[self app] presentLocalNotificationNow:batteryNotification];
//    }

    
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [self removeRegionsFromMonitoring:appRegions];
}

#pragma mark - CoreLocationManagerDelegate Methods


-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Something failed to update for location services");
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {

    NSLog(@"Entered region %@", [region identifier]);
    for (int i = 0; i < [locationNames count]; i++) {
        if ([[locationNames objectAtIndex:i] rangeOfString:[region identifier]].location != NSNotFound) {
            location = i;
        }
    }
    [self updateIndexForFoundRegion:region];
    [self presentNotificationForCenter:[NSString stringWithFormat:@"Entering %@", [region identifier]]];
}

-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    NSLog(@"left region %@", [region identifier]);
    [self presentNotificationForCenter:[NSString stringWithFormat:@"Exiting %@", [region identifier]]];
}

-(void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    
    NSLog(@"Now monitoring %@\nMonitoring count: %d", [region identifier], [[locationManager monitoredRegions] count]);
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
        case CLRegionStateInside:
            result = @"INSIDE";
            [self updateIndexForFoundRegion:region];
            [self presentNotificationForCenter:[NSString stringWithFormat:@"At %@", [region identifier]]];
            break;
        case CLRegionStateOutside:
            result = @"OUTSIDE";
        default:
            result = @"UNKNOWN";
            break;
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

#pragma mark - Notification Methods


-(void) updateIndexOfLastViewController:(NSNotification *)notification {
    
    if ([[notification userInfo] objectForKey:@"CurrentViewController"]) {
        lastViewController = [[notification userInfo] objectForKey:@"CurrentViewController"];
        int result = NOT_SET;
        if ([lastViewController isKindOfClass:[AddDeviceController class]]) {
            result = ADD_DEVICE;
        }
        if ([lastViewController isKindOfClass:[RemoveDeviceController class]]) {
            result = REMOVE_DEVICE;
        }
        if ([lastViewController isKindOfClass:[AlterDeviceController class]]) {
            result = CHANGE_DEVICE;
        }
        if ([lastViewController isKindOfClass:[ReplaceDeviceController class]]) {
            result = REPLACE_DEVICE;
        }
        if ([lastViewController isKindOfClass:[SettingsController class]]) {
            result = SETTINGS;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:result forKey:@"ConfigChanger.Mode"];
        [defaults synchronize];
        defaults = nil;
    }
}

#pragma mark - Helper methods


-(NSSet*) createAppRegions {
    
    locationNames = [NSArray arrayWithObjects: @"Home", @"JSC", @"WSTF", @"JPL", @"KSC", @"LARC", nil];
    CLLocationDistance defaultDistance = 3 * METERS_PER_MILE;
    CLLocationDistance  wstfDistance = 100 * METERS_PER_MILE;
    double longitudes[] = { 29.53542276, 29.5630,  32.33555556, 0, 28.51944444, 37.08583333};
    double latitdutes[] = { -95.21776079, -95.0910,  -106.4058333, 0, -80.67, -76.38055556};
    NSMutableArray *tempListing = [[NSMutableArray alloc] init];
    for (int i = 0; i < [locationNames count]; i++) {
        CLLocationCoordinate2D  currentCoord = {longitudes[i], latitdutes[i]};
        CLCircularRegion *currentRegion;
        
        if ([[locationNames objectAtIndex:i] rangeOfString:@"WSTF"].location != NSNotFound) {
            currentRegion = [[CLCircularRegion alloc] initWithCenter:currentCoord radius:wstfDistance identifier:@"WSTF"];
        } else {
            currentRegion = [[CLCircularRegion alloc] initWithCenter:currentCoord radius:defaultDistance identifier:[locationNames objectAtIndex:i]];
        }
        NSLog(@"making %@", [currentRegion identifier]);
        [tempListing addObject:currentRegion];
    }
    NSSet *results = [NSSet setWithArray:tempListing];
    return results;
}


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
    NSLog(@"Initial regions count: %d", [[locationManager monitoredRegions] count]);
    [self removeRegionsFromMonitoring:[locationManager monitoredRegions]];
    appRegions = [self createAppRegions];
    NSLog(@"Cleared regions count: %d", [[locationManager monitoredRegions] count]);
    [self addRegionsToMonitor:appRegions];
    NSLog(@"The app regions monitored is %d", [[locationManager monitoredRegions] count]);
}

-(void) removeRegionsFromMonitoring:(NSSet *)regions {
    
    for (CLRegion *currentRegion in regions) {
        [locationManager stopMonitoringForRegion:currentRegion];
    }
}

-(void) addRegionsToMonitor:(NSSet *)regions {
    
    for (CLRegion *currentRegion in regions) {
        [locationManager startMonitoringForRegion: currentRegion];
        [locationManager requestStateForRegion:currentRegion];
    }
}

-(void) updateIndexForFoundRegion: (CLRegion*) region {
    
    NSArray *listOfRegions = [NSArray arrayWithArray:[appRegions allObjects]];
    for (int i = 0; i < [appRegions count]; i++) {
        CLRegion *currentRegion = [listOfRegions objectAtIndex:i];
        if ([[region identifier] rangeOfString:[currentRegion identifier]].location != NSNotFound) {
            location = i;
            NSLog(@"Found %@", [region identifier]);
        }
    }
}

-(void) presentNotificationForCenter: (NSString*) message {
    
    UILocalNotification *foundNotification = [[UILocalNotification alloc] init];
    [foundNotification setAlertBody:message];
    [foundNotification setSoundName:UILocalNotificationDefaultSoundName];
    [foundNotification setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] presentLocalNotificationNow:foundNotification];
}
@end


