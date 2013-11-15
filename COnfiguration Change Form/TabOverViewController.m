//
//  ChangeSelectorController.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "TabOverViewController.h"
#import "FormViewControllerFactory.h"
#import "SettingsController.h"
#import "UIColor+ExtendedColor.h"
#import "enumList.h"
#import "FormViewController.h"

@interface TabOverViewController ()

@end

@implementation TabOverViewController

@synthesize addDeviceViewer;
@synthesize removeDeviceViewer;
@synthesize replaceDeviceViewer;
@synthesize changeDeviceViewer;
@synthesize settingsViewer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSArray *tabIcons = [NSArray arrayWithObjects:@"adddv1.png", @"rmdv1.png", @"changedv2.png", @"changedv1.png", @"settings.png", nil];
    FormViewController *addView = [FormViewControllerFactory createFormView: ADD];
    FormViewController *removeView = [FormViewControllerFactory createFormView: REMOVE];
    FormViewController *replaceView = [FormViewControllerFactory createFormView: REPLACE];
    FormViewController *changeView = [FormViewControllerFactory createFormView: OTHER];
    SettingsController *settingsView = [[SettingsController alloc] init];
    NSArray *viewcontrollerArray = [NSArray arrayWithObjects:addView, removeView, replaceView, changeView, settingsView, nil];
    NSMutableArray *navControllers = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < [viewcontrollerArray count]; i++) {
        [navControllers setObject:[[UINavigationController alloc] initWithRootViewController:[viewcontrollerArray objectAtIndex:i]]atIndexedSubscript:i];
        [[[navControllers objectAtIndex:i] navigationBar] setBackgroundColor:[UIColor textColor]];
        [[[navControllers objectAtIndex:i] tabBarItem] setImage:[UIImage imageNamed:[tabIcons objectAtIndex:i]]];
    }
    [self setViewControllers:navControllers animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    addDeviceViewer =nil;
    removeDeviceViewer = nil;
    replaceDeviceViewer = nil;
    changeDeviceViewer =nil;
    settingsViewer = nil;
}

@end
