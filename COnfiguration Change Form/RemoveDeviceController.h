//
//  AddOrRemoveDeviceController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This class was created to avoid confusion at the tab view controller.  The name implies
 * that the view controller will be used for removing devices while allowing extensibility without
 * harming classes that are based on the super class of FormViewController.  It overrides super
 * class methods for its individual use.
 */

#import "FormViewController.h"

@interface RemoveDeviceController : FormViewController

@end
