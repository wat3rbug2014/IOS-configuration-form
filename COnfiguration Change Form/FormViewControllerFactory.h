//
//  FormViewControllerFactoryViewController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This class is a factory class for creating the view controllers for the tab 
 * view controller for the application.  It is meant as a central point of creation
 * so that polymorphic behavior can be used.  See enumList.h for connectType enum values
 * that can be passed to this class.
 */

#import "FormViewController.h"
#import "AddDeviceController.h"
#import "RemoveDeviceController.h"
#import "ReplaceDeviceController.h"
#import "ConnectionsController.h"
#import "AlterDeviceController.h"
#import "FormViewProtocol.h"

@interface FormViewControllerFactory : NSObject


/**
 * Creates a view controller based on integer values passed to it.  See enumList.h for connectType
 * enum values for the acceptable range of values to pass to this method.
 *
 * @param type the enum value used for selecting which view controller to create.
 *
 * @return A subclass of the FormViewController class.
 */

+(id<FormViewProtocol>) createFormView:(int) type;

@end
