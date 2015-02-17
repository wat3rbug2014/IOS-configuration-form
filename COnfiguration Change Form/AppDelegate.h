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


/**
 * The display window for the application.
 */

@property (strong, nonatomic) UIWindow *window;


/**
 * The index used by the device data objects for determining which center the user is location in.
 */

@property int location;


/**
 * The location manager instance used for the application.
 */

@property (strong, retain) CLLocationManager *locationManager;


/**
 * The flag that is used to determine whether to continue trying to use location services.
 */

@property BOOL locationUpdatesAllowed;


/**
 * The list of names that will be used for creating the location regions.
 */

@property NSArray *locationNames;


/**
 * The listing of regions that the app will use for monitoring.
 */

@property NSSet *appRegions;


/**
 * This method provides a means to update the index used by the data objects for the center.
 * The region that is passed will be checked to see if it matches anything in the appRegions.
 * 
 * region The discovered region that is checked against the list.
 */

-(void) updateIndexForFoundRegion: (CLRegion*) region;


/**
 * This method does the checking to see if location services are allowed by the user and the
 * device.  Then it sets up the locationmanager in order to monitor for proximity to the
 * targeted centers.
 */

-(void) setupLocationMonitoring;


/**
 * This method adds an NSSet of regions to provide monitoring for the purposes of this app.
 * NOTE: A maximum of 20 regions can be monitored for the CLLocationManager.
 *
 * regions A set regions to start monitoring.
 */

-(void) addRegionsToMonitor: (NSSet*) regions;


/**
 * This method provides a means of cleaning up the locationmanager for the regions it monitors.
 * The locationmanager is constrained to doing approximately 20 locations, so it is important to 
 * clean up prior instances.  At this moment no overlap between other apps has been observed so
 * this method makes the assumption that the regions were created by this app.  The return type
 * for [locationmanager monitoredRegions] is NSSet.  For this reason the method accepts NSSet
 * instead of NSArray.  
 *
 * regions A set of regions that will be removed.
 */

-(void) removeRegionsFromMonitoring: (NSSet*) regions;


/**
 * Provides a method to give banner notifcations to the phone. The message is determined
 * prior to delivery to this message.  No further processing will happen to the message.
 *
 * @param message The message that the banner is going to display.
 */

-(void) presentNotificationForCenter: (NSString*) message;

@end
