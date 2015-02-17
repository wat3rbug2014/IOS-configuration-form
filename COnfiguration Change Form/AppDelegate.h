//
//  AppDelegate.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define MAX_ALLOWED_REGIONS 20
#define METERS_PER_MILE 1609.34

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property id lastViewController;
@property int location;
@property (strong, retain) CLLocationManager *locationManager;
@property BOOL locationUpdatesAllowed;
@property NSArray *locationNames;
@property NSSet *previousRegions;
@property NSSet *appRegions;

-(void) updateIndexOfLastViewController: (NSNotification*) notification;

-(void) updateIndexForFoundRegion: (CLRegion*) region;
-(void) setupLocationMonitoring;
-(void) addRegionsToMonitor: (NSSet*) regions;
-(void) removeRegionsFromMonitoring: (NSSet*) regions;
-(void) presentNotificationForCenter: (NSString*) message;

@end
