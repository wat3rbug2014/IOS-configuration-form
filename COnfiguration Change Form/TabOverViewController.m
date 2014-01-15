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
@synthesize alterDeviceViewer;
@synthesize settingsViewer;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setRestorationIdentifier:@"Tab"];
        [self setRestorationClass:[self class]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSArray *tabIcons = [NSArray arrayWithObjects:@"adddv2.png", @"rmdv2.png", @"alterdv.png", @"changedv2.png", @"settings.png", nil];
    NSArray *tabSelectedIcons = [NSArray arrayWithObjects:@"adddv2_selected.png", @"rmdv2_selected.png", @"alterdv_selected.png",  @"changedv2.png", @"settings_selected.png", nil];
    NSArray *restoreIDs = [NSArray arrayWithObjects:@"AddNav", @"RemoveNav", @"ReplaceNav", @"AlterNav", @"SetingNav", nil];
    FormViewController *addView = [FormViewControllerFactory createFormView: ADD];
    FormViewController *removeView = [FormViewControllerFactory createFormView: REMOVE];
    FormViewController *replaceView = [FormViewControllerFactory createFormView: REPLACE];
    FormViewController *changeView = [FormViewControllerFactory createFormView: OTHER];
    SettingsController *settingsView = [[SettingsController alloc] init];
    NSArray *viewcontrollerArray = [NSArray arrayWithObjects:addView, removeView, changeView, replaceView, settingsView, nil];
    NSMutableArray *navControllers = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < [viewcontrollerArray count]; i++) {
        [navControllers setObject:[[UINavigationController alloc] initWithRootViewController:[viewcontrollerArray objectAtIndex:i]]atIndexedSubscript:i];
        [[[navControllers objectAtIndex:i] navigationBar] setBackgroundColor:[UIColor textColor]];
        UIImage *selected = [UIImage imageNamed: [tabSelectedIcons objectAtIndex:i]];
        UIImage *normal = [UIImage imageNamed:[tabIcons objectAtIndex:i]];
        normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [[[navControllers objectAtIndex:i] tabBarItem] setSelectedImage:selected];
        [[[navControllers objectAtIndex:i] tabBarItem] setImage:normal];
        [[navControllers objectAtIndex:i] setRestorationIdentifier:[restoreIDs objectAtIndex:i]];
    }
    [self setViewControllers:navControllers animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    addDeviceViewer =nil;
    removeDeviceViewer = nil;
    replaceDeviceViewer = nil;
    alterDeviceViewer =nil;
    settingsViewer = nil;
}

-(BOOL) shouldAutorotate {
    
    return  NO;
}

@end
