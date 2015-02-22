//
//  ConfigurationDataProtocol.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This protocol is created for contract enforcement by the subclassed
 * datatype for compiler checks.  It sets setters and getters for the data
 * models that are basic and the ones that are optional because not all of the
 * data models require them.  At this moment, I'm not sure if that adds more 
 * simplicity than the occasional call to see if the particular class supports
 * the desired selector.
 */

#import <Foundation/Foundation.h>

@protocol ConfigurationDataProtocol <NSObject>


#pragma mark - Required methods

@required


/**
 * This method returns the building information string.
 *
 * @return The building expressed as a string.
 */

-(NSString*) building;


/**
 * This method sets the building information string.
 *
 * @param building The building expressed as a string.
 */

-(void) setBuilding: (NSString*) building;


/**
 * This method returns the string designation for the closet where the equipment is located.
 *
 * @return The closet expressed as a string.
 */

-(NSString*) closet;


/**
 * This methods sets the string designation for the closet where the equipment is located.
 *
 * @param closet The string representation of the closet.
 */

-(void) setCloset: (NSString*) closet;


/**
 * This method retrieves the string designation for the tag of the equipment.
 *
 * @return The string representation of the equipment tag.
 */

-(NSString*) tag;


/**
 * This method sets the string designation for the tag of the equipment.
 *
 * @param currentTag The string representation of the equipment tag.
 */

-(void) setTag: (NSString*) currentTag;



/**
 * This method returns the comments made about the device and anything to do with
 * the activity that this data model is explaining.
 *
 * @return The string containing the entire comment.
 */

-(NSString*) comments;


/**
 * This method sets the comments to be made about the equipment or the activity that
 * it is involved in.  This method does not do concatenation but replacement.
 *
 * @param comment The string containg the entire comment.
 */

-(void) setComments: (NSString*) comment;


/**
 * This method returns an integer that is the equivalent of something listed in the
 * enumList.h.
 *
 * @return An integer representing the device type.
 */

-(NSInteger) deviceType;


/**
 * Set the device type as it correlates to the enumList.h file.
 *
 * @param type An integer representing the device type.
 */

-(void) setDeviceType: (NSInteger) type;


/**
 * This method will add an email address along with its associated name to the
 * NSUserDefaults section.
 *
 * @param email The email address
 * @param name The name associated with the email address.
 */

-(void) addEmailAddress: (NSString*) email withName: (NSString*) name;


/**
 * This method will remove the email address and the associated name for the email
 * address.
 *
 * @param name The name that will be used to remove the key-value pair for the email
 * address.
 */

-(void) removeEmailAddress: (NSString*) name;


/**
 * This method creates the message body for the email and returns the string representation.
 *
 * @return The message to be used in the email.
 */

-(NSString*) getEmailMessageBody;


/**
 * This method creates the subject line for the email.
 *
 * @return The subject line for the email.
 */

-(NSString*) getEmailSubject;


/**
 * This is method designed to be overridden for the particular data class so that
 * all necessary items are filled out before trying to make an email message.  YES
 * means that everything that is required has been supplied.
 *
 * @return The boolean flag for whether all required items are available.
 */

-(BOOL) isFormFilledOut;


/**
 * This method returns a name for the array of email address based on the index.
 * Its use is for the SettingsController which maps a name and email address to a
 * particular UITableViewCell.
 *
 * @param index The index value that will be used got get a name for the TableView.
 *
 * @return A string representation of the name associated with an email address.
 */

-(NSString*) getNameAtIndex: (NSInteger) index;


/**
 * This method returns an email address for the array of email address/names based 
 * on the index.  Its use is for the SettingsController which maps a name and email 
 * address to a particular UITableViewCell.
 *
 * @param index The index value that will be used got get an email address for the 
 * TableView.
 *
 * @return A string representation of the email address associated with a name.
 */

-(NSString*) getEmailAtIndex: (NSInteger) index;


/**
 * The number of email addresses that are currently stored by the application.  This 
 * does not include any email addresses that are part of a distribution list.  A 
 * distribution only counts as one item.
 *
 * @return An integer value expressing the number of email addresses that will be
 * used when filling out the email.
 */

-(NSInteger) emailCount;


/**
 * This method is not meant to be public.  It is meant to retrieve email names and
 * addresses from the NSUserDefaults.
 */

-(void) getStoredEmailSettings;


/**
 * This method is not meant to be public.  It is meant to store the email names and
 * addresses to NSUserDefaults.
 */

-(void) updateStoredEmailSettings;


/**
 * This method gets all of the selected email addresses.
 *
 * @return An array of strings containing the selected email addresses.
 */

-(NSArray*) getMailingList;


/**
 * This method is meant to be used by the SettingsController so that cell selection
 * will remove the desired email address and name from the stored email addresses
 * for the application.  It makes the assumption that the email address and the name
 * correlate correctly with the arrays containing those string.
 *
 * @param index An integer that correlates with the location in the array for the
 * email address and name so that they are removed from the list of stored email
 * addresses.
 */

-(void) removeEntryAtIndex: (NSInteger) index;


/**
 * This method returns a complete device name which includes the center, device type, building,
 * closet, and unique tag number for the device.
 *
 * @return The string value for the complete device name.
 */

-(NSString*) getDeviceName;


/**
 * This methods returns a two character string of the device type based on what is selected.
 * See enumList.h for the device type abbreviations.
 *
 * @return String with 2 character representing the device type.
 */

-(NSString*) getDeviceTypeString;


/**
 * This methods returns an abbreviation of the center names.  This is not to be confused with
 * the getSiteAbbreviatedString() method.  As an example JPL is used for Jet Propulsion Lab will
 * return a value of 'JPL'.
 *
 * @return A acronym value of the center name.
 */

-(NSString*) getSiteString;


/**
 * This methods returns a two character representation of the NASA center that is to be
 * used in creating the device name.  As an example JPL or Jet Propulsion Lab will return a
 * value of 'jp'.
 *
 * @return Two character string for the center.
 */

-(NSString*) getSiteAbbreviatedString;


/**
 * This methods returns a two character representation of the device type.  See enumList.h for
 * the device types.
 *
 * @return Two character representation of the device type.
 */

-(NSString*) getAbbreviateDeviceString;


#pragma mark - Optional methods

@optional


/**
 * This getter method returns the value of the port that is used on the device for
 * connectivity and is the first one.  Most data models in this application require
 * its use exception for replacement.
 *
 * @return The string representation of the first port used on the device.
 */

-(NSString*) uplinkOneFrom;


/**
 * This setter method sets the value of the port that is used on the device for
 * connectivity and is the first one.  Most data models in this application require
 * its use exception for replacement.
 *
 * @param The string representation of the first port used on the device.
 */

-(void) setUplinkOneFrom: (NSString*) linkOne;


/**
 * This getter method gets the value of the port that is used on the distant end 
 * device for connectivity and is the first one.  Most data models in this application 
 * require its use exception for replacement.
 *
 * @return The string representation of the first port used on the device at the distant
 * end device.
 */

-(NSString*) uplinkOneTo;


/**
 * This setter method gets the value of the port that is used on the distant end
 * device for connectivity and is the first one.  Most data models in this application
 * require its use exception for replacement.
 *
 * @param The string representation of the first port used on the device at the distant
 * end device.
 */

-(void) setUplinkOneTo: (NSString*) linkTo;


/**
 * This getter method returns the value of the tag that is used on the distant end
 * device for connectivity and is the first one.
 *
 * @return The string representation of the first device tag at the distant end device.
 */

-(NSString*) destOneTag;


/**
 * This setter method sets the value of the tag that is used on the distant end
 * device for connectivity and is the first one.
 *
 * @param The string representation of the first device tag at the distant end device.
 */

-(void) setDestOneTag: (NSString*) destTag;


/**
 * This getter method gets the value of the port that is used on the distant end device
 * for connectivity and is the second one.  Most data models in this application require
 * its use exception for replacement.
 *
 * @return The string representation of the second port used on the device.
 */

-(NSString*) uplinkTwoFrom;


/**
 * This setter method sets the value of the port that is used on the distant end device
 * for connectivity and is the second one.  Most data models in this application require
 * its use exception for replacement.
 *
 * @param The string representation of the second port used on the device.
 */

-(void) setUplinkTwoFrom: (NSString*) linkTwo;


/**
 * This getter method gets the value of the port that is used on the distant end
 * device for connectivity and is the second one.  
 *
 * @return The string representation of the second port used on the device at the distant
 * end device.
 */

-(NSString*) uplinkTwoTo;


/**
 * This setter method sets the value of the port that is used on the distant end
 * device for connectivity and is the second one.
 *
 * @param The string representation of the second port used on the device at the distant
 * end device.
 */

-(void) setUplinkTwoTo: (NSString*) linkTo;


/**
 * This getter method returns the value of the tag that is used on the distant end
 * device for connectivity and is the second one.
 *
 * @return The string representation of the second device tag at the distant end device.
 */

-(NSString*) destTwoTag;


/**
 * This setter method sets the value of the tag that is used on the distant end
 * device for connectivity and is the second one.
 *
 * @param The string representation of the second device tag at the distant end device.
 */

-(void) setDestTwoTag: (NSString*) destTag;


/**
 * This getter method returns the tag of the existing equipment.  This method is used in all
 * data model types except the replacement model.  The oldTag is the default tag for other
 * data models.
 *
 * @return oldTag The tag string for the existing equipment, or in the case of replacement, the
 * old equipment.
 */

-(NSString*) oldTag;


/**
 * This setter method sets the tag of the existing equipment.  This method is used in all
 * data model types except the replacement model.  The oldTag is the default tag for other
 * data models.
 *
 * @param oldTag The tag string for the existing equipment, or in the case of replacement, the
 * old equipment.
 */

-(void) setOldTag: (NSString*) tag;


/**
 * This getter method returns the string representation of an IP address.
 *
 * @return A string representation of an IP address or various combinations.
 */

-(NSString*) ipAddress;


/**
 * This setter method allows IPv4 addresses or abbreviated addresses such as 
 * ins.170.3.
 *
 * @param ip The string representation of an IP address or an idea for an IP address.
 */

-(void) setIpAddress: (NSString*) ip;


/**
 * This setter method sets the vlan number.
 *
 * @param An NSNumber representation of the vlan.
 */

-(void) setVlan: (NSNumber*) vlan;


/**
 * This methods returns the integer value of a vlan since the range is from 1
 * to 4000.
 *
 * @return Integer value for vlan.
 */

-(int) vlan;


/**
 * This method takes a string input and and converts it to integer and allows it to
 * be stored in the particular data model.
 *
 * @param vlanString a string that represents a vlan as a number from 1-4000.
 */

-(void) setVlanFromString: (NSString*) vlanString;

@end
