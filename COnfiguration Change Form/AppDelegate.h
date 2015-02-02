//
//  AppDelegate.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property id lastViewController;
@property int location;
@property CLLocationManager *locationManager;
@property BOOL locationUpdatesAllowed;
@property NSArray *locationListing;
@property NSArray *locationNames;

-(void) updateIndexOfLastViewController: (NSNotification*) notification;

-(void) updateCenterLocation: (NSNotification*) notification;
-(void) loadRegions;
@end
