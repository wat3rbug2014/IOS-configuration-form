//
//  RemoveDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/12/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This is the superclass for all the datamodels because it has some essentials that all
 * of the datamodels need.  One possible need for redesign may be the need to move the
 * email recipients to a managed data model or something that allows a lot of email
 * recipients, as the NSUserDefaults has a limited section of memory for its storage.
 * As it stands right now, onbe distribution list is noted in the settings.
 */

#import <Foundation/Foundation.h>
#import "ConfigurationDataProtocol.h"
#import "enumList.h"

@interface BasicDeviceData : NSObject <ConfigurationDataProtocol>


/**
 * The building the equipment is located in.
 */

@property (retain) NSString *building;


/**
 * The closet the equipment is located in.
 */

@property(retain) NSString *closet;


/**
 * The unique tag number for the equipment.
 */

@property (retain) NSString *tag;


/** 
 * The IP address of the equipment.
 */

@property (retain) NSString *ipAddress;


/**
 * The VLAN that the equipment is inhabiting.
 */

@property NSInteger vlan;


/**
 * The comments for the operation that the equipment is involved in.
 */

@property (retain) NSString *comments;


/**
 * The integer value for the device type of the equipment.
 */

@property NSInteger deviceType;


/**
 * The dictionary of key-value pairs that contain the selected email addresses
 * and names.
 */

@property (retain) NSMutableDictionary *emailAddresses;


/**
 * An array of the names used for the tableview for the email recipients.
 */


@property (retain) NSArray *nameArray;


/**
 * An array of the email addresses for the table view for email recipients.
 */

@property (retain) NSArray *emailArray;


/**
 * A shared instance of the UIapplication for use in determining which center
 * the user is located in.
 */

@property (readonly) UIApplication *application;


/**
 * The setter for the equipment tag.
 *
 * @param The string representation for the equipment tag.
 */

-(void) setOldTag: (NSString*) newTag;


/**
 * The getter for the equipment tag.
 *
 * @return The string representation for the equipment tag.
 */

-(NSString*) oldTag;


/**
 * The setter for the VLAN using an integer value.
 *
 * @param An integer value for the vlan.
 */

-(void) setVlan:(NSInteger)vlan;


/**
 * The setter for the VLAN using a string value.
 *
 * @param The string representation for the VLAN.
 */

-(void) setVlanFromString: (NSString*) newVlan;


/**
 * This method returns an integer value for the NASA site.  This value is determined
 * based on location tracking, so it is not statically stored.
 */

-(int) site;

@end
