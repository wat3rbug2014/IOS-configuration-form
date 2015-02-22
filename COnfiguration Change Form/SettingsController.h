//
//  SettingsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This is a viewcontroller that has a table of the contacts that have been selected
 * for emailing the resultant form to the recipents that are listed.  It allows for
 * selection of recipients as well as deselection of the recipients.
 */

#import <UIKit/UIKit.h>
#import "BasicDeviceData.h"
#import "enumList.h"
#import <AddressBookUI/AddressBookUI.h>

@interface SettingsController : UITableViewController
<ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate>


/**
 * This datamodel is used because all data models reference a NSUserDefaults section 
 * which has the list of recipients that will be emailed.
 */

@property (retain) BasicDeviceData *appData;


/**
 * This method creates an ABPeoplePickerNavigationController instance and hands over control.
 * It is noted that this viewcontroller is also the delegate, so the delegate methods handle
 * the selection of email recipients and dismissal of the view.
 */

-(void) addContacts;

@end
