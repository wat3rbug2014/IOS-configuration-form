//
//  ReplaceDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/8/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//
/**
 * This data model supports the replacement of equipment.  It is probably
 * the least restrictive of the data models because so little information 
 * is required.  Essential the tag numbers for the devices change, but a
 * few other items are need for the network map folks so that they can update
 * the maps with less frustration.
 */

#import "BasicDeviceData.h"

@interface ReplaceDeviceData : BasicDeviceData


/**
 * This tag is for the old equipment that has been removed from service.
 */

@property (retain) NSString *oldTag;


/**
 * This method is for setting the tag for the equipment that is being installed.
 * This is the setter for the value needed by this data model.
 *
 * @param currentTag is device tag for the new device.
 */

-(void) setCurrentTag: (NSString*) currentTag;


/**
 * This is the getter method for the new equipment for this data model.
 */

-(NSString*) currentTag;

@end
