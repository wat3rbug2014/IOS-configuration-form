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

@implementation AppDelegate

@synthesize lastViewController;

enum selectedView {
    NOT_SET,
    ADD_DEVICE,
    REMOVE_DEVICE,
    CHANGE_DEVICE,
    REPLACE_DEVICE,
    SETTINGS
};


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
    
    // setup notification to update view index
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(updateIndexOfLastViewController:)
                name:@"CurrentViewController" object:nil];
    
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
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

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
@end
