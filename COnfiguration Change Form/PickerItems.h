//
//  PickerItems.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/1/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//
// Just a basic data structure because these items are common
// among the three views


/**
 * Data class to support UIPickerController that is used for selecting devices
 */

#import <Foundation/Foundation.h>

@interface PickerItems : NSObject


/**
 * The array of devices by full name
 */

@property (retain, readonly) NSArray *items;


/**
 * The array of device abbreviations in the same order as the devices in items array.
 */

@property (retain, readonly) NSArray *deviceAbbr;


/**
 * The number of items in the items array.  It is dynamic based on the contents of the array
 * for the items.
 *
 * @return An integer value of the number of devices in the array.
 */

-(NSInteger) count;


/**
 * The method returns the string value based on the index passed to it.  This method
 * is not designed to be used outside of the class. If the index is out of range, the first 
 * element is returned.
 *
 * @param index The integer value used for getting the device type name.
 *
 * @return The string that is the name of the device type.
 */

-(NSString*) deviceAtIndex: (NSInteger) index;


/**
 * This method returns the device abbreviation based on the index that is passed to it.  It makes a 
 * few assumptions. The items array and the deviceAbbr array are in sync with each other.
 *
 * @param device is an integer that references an index for the device name.
 *
 * @return The abbreviated device name for use with creating the final name for a particular device.
 */

-(NSString*) getAbbreviatedDeviceString: (NSInteger) device;

@end
