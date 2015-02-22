//
//  AddDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This class extends the BasicDeviceData class so that it can be used in
 * the AddDeviceViewController for adding devices.  It is a data model to 
 * be used by the view controller.
 */

#import "BasicDeviceData.h"
#import "ConfigurationDataProtocol.h"

@interface AddDeviceData : BasicDeviceData <ConfigurationDataProtocol>


/**
 * This value is the first uplink where the side is on the device
 * that is being reported.
 */

@property (retain) NSString* uplinkOneFrom;


/**
 * This value is the first uplink on the side that is connecting to
 * existing equipment, and not the device that is being added.
 */

@property (retain) NSString* uplinkOneTo;


/**
 * This value is the second uplink where the side is on the device
 * that is being reported.  It can be optional, because not all devices
 * will have 2 uplinks.
 */

@property (retain) NSString* uplinkTwoFrom;


/**
 * This value is the second uplink on the side that is connecting to
 * existing equipment, and not the device that is being added.  It is 
 * optional, because not all devices will have 2 uplinks.
 */

@property (retain) NSString* uplinkTwoTo;


/**
 * This value is the tag number of the distant end device for the first
 * uplink.
 */

@property (retain) NSString* destOneTag;


/**
 * This value contains the tag number of the distant end device for the
 * second uplink.  It is optional because the second link may not be
 * configured.
 */

@property (retain) NSString* destTwoTag;

@end
