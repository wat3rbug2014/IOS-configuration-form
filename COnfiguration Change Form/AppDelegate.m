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
@synthesize locationListing;
@synthesize locationUpdatesAllowed;
@synthesize locationNames;

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
    
    locationNames = [NSArray arrayWithObjects: @"Home", @"JSC", @"WSTF", @"JPL", @"KSC", @"LARC", nil];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    locationUpdatesAllowed = NO;
    [locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        locationUpdatesAllowed = YES;
    }
    if (locationUpdatesAllowed) {
        [self loadRegions];
        //[locationManager startMonitoringSignificantLocationChanges];
        [locationManager startUpdatingLocation];
    }
    // setup notification to update view index
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateIndexOfLastViewController:) name:@"CurrentViewController" object:nil];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        // pass on the ability to use location services
    }
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

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
    
    [locationManager stopUpdatingLocation];
}

#pragma mark - CoreLocationManagerDelegate Methods


-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Something failed to update for location services");
}
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
   // NSLog(@"Location is %@", [[locations objectAtIndex:0] description]);
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {

    NSLog(@"Found region %@", [region identifier]);
    NSNotification *enteredLocationNoticiation = [[NSNotification alloc] initWithName:@"LocationUpdated" object:region userInfo:nil];
    [self updateCenterLocation:enteredLocationNoticiation];
}

#pragma mark - Notification Methods


-(void) updateIndexOfLastViewController:(NSNotification *)notification {
    
    NSLog(@"Swapping views and noticed");
    if ([[notification userInfo] objectForKey:@"CurrentViewCOntroller"]) {
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

-(void) updateCenterLocation:(NSNotification *)notification {
    
    NSLog(@"Updating datafiles");
    // send out notification
    // update badging
    
}

#pragma mark - Helper methods

-(void) loadRegions {
    
    CLLocationDirection defaultDistance = 1;
    CLLocationDistance  wstfDistance = 100 * 1609.34;
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
        [tempListing addObject:currentRegion];
        [locationManager startMonitoringForRegion:currentRegion];
    }
    locationListing = tempListing;
}

@end


