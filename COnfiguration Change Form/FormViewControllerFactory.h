//
//  FormViewControllerFactoryViewController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "FormViewController.h"
#import "AddDeviceViewController.h"
#import "RemoveDeviceViewController.h"
#import "ReplaceDeviceController.h"
#import "ConnectionsController.h"

@interface FormViewControllerFactory : NSObject


+(id) createFormView:(int) type;

@end
