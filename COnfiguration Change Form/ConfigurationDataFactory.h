//
//  ConfigurationDataFactory.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This factory class is used for creating the data model class based on 
 * the enum used in enumList.h for the type of application operation needed.
 * The idea is to use a factory for creating the class and using polymorphic
 * behavior.
 */

#import <Foundation/Foundation.h>
#import "ConfigurationDataProtocol.h"
#import "enumList.h"

@interface ConfigurationDataFactory : NSObject


/**
 * This class method requires an integer from enumList.h and creates a DeviceData class
 * appropriate to the operation described.
 *
 * @param An integer for one of the operations, Add, Alter, Replace, and Remove devices.
 *
 * @return An instance of a DeviceData class which conforms to the ConfigurationDataProtocol.
 */

+(id<ConfigurationDataProtocol>) create: (int) formType;

@end
