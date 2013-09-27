//
//  ChangeSelectorController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabOverViewController : UITabBarController

@property (retain) UINavigationController *addDeviceViewer;
@property (retain) UINavigationController *removeDeviceViewer;
@property (retain) UINavigationController *changeDeviceViewer;
@property (retain) UINavigationController *settingsViewer;


@end
