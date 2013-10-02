//
//  ChangeSelectorController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "TabOverViewController.h"
#import "AddOrRemoveDeviceController.h"
#import "ChangeDeviceController.h"
#import "SettingsController.h"
#import "UIColor+ExtendedColor.h"

@interface TabOverViewController ()

@end

@implementation TabOverViewController

@synthesize addDeviceViewer;
@synthesize removeDeviceViewer;
@synthesize changeDeviceViewer;
@synthesize settingsViewer;

int static const CONTROLLER_NUM = 4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *tabIcons = [NSArray arrayWithObjects:@"adddevice.png", @"rmdevice.png", @"changedevice.png", @"adddevice.png", nil];
    AddOrRemoveDeviceController *addView = [[AddOrRemoveDeviceController alloc] initAsAddView:YES];
    AddOrRemoveDeviceController *removeView = [[AddOrRemoveDeviceController alloc] initAsAddView:NO];
    ChangeDeviceController *changeView = [[ChangeDeviceController alloc] init];
    SettingsController *settingsView = [[SettingsController alloc] init];
    NSArray *viewcontrollerArray = [NSArray arrayWithObjects:addView, removeView, changeView, settingsView, nil];
    NSMutableArray *navControllers = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < CONTROLLER_NUM; i++) {
        [navControllers setObject:[[UINavigationController alloc] initWithRootViewController:[viewcontrollerArray objectAtIndex:i]]atIndexedSubscript:i];
        [[[navControllers objectAtIndex:i] navigationBar] setBackgroundColor:[UIColor textColor]];
        [[[navControllers objectAtIndex:i] tabBarItem] setImage:[UIImage imageNamed:[tabIcons objectAtIndex:i]]];
    }
    [self setViewControllers:navControllers animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    addDeviceViewer =nil;
    removeDeviceViewer = nil;
    changeDeviceViewer =nil;
    settingsViewer = nil;
}

@end
