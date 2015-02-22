//
//  ChangeSelectorController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This viewcontroller has all five viewcontrollers and handles the
 * intialization of those controllers so that the AppDelegate is easier
 * to read to troubleshoot.
 */

#import <UIKit/UIKit.h>

@interface TabOverViewController : UITabBarController


/**
 * This controller handles the information gathering for the purposes
 * of creating a form that gives the details of a device that has been
 * added to the network.
 */

@property (retain) UINavigationController *addDeviceViewer;


/**
 * This controller handles the information gathering for the purposes
 * of creating a form that gives the details of a device that has been
 * removed from the network.
 */

@property (retain) UINavigationController *removeDeviceViewer;


/**
 * This controller handles the information gathering for the purposes
 * of creating a form that gives the details of a device that has been
 * replaced by another device on the network.
 */

@property (retain) UINavigationController *replaceDeviceViewer;


/**
 * This controller handles the information gathering for the purposes
 * of creating a form that gives the details of a device that has been
 * altered in its configuration.
 */

@property (retain) UINavigationController *alterDeviceViewer;


/**
 * This viewcontroller handles the selection of the recipients that the
 * resultant form will be mailed to when the form is completed.
 */

@property (retain) UINavigationController *emailRecipientsSelector;


@end
