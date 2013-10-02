//
//  SettingsController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "enumList.h"
#import <AddressBookUI/AddressBookUI.h>

@interface SettingsController : UITableViewController <ABPeoplePickerNavigationControllerDelegate>

@property (retain) ConfigurationData *appData;

-(void) addContacts;

@end
