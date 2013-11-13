//
//  ConfigurationData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "RemoveDeviceData.h"

@interface ConfigurationData : RemoveDeviceData

@property NSInteger deviceType;
@property NSInteger site;
@property BOOL isReadyToSend;

@property (retain) NSMutableDictionary *emailAddresses;
@property (retain) NSArray *nameArray;
@property (retain) NSArray *emailArray;

-(NSString*) getDeviceName;
-(NSString*) getDeviceTypeString;
-(NSString*) getSiteString;
-(NSString*) getSiteAbbreviatedString;
-(NSString*) getAbbreviateDeviceString;
-(void) clear;
-(BOOL) isFormFilledOut;

// email methods

-(void) addEmailAddress: (NSString*) email withName: (NSString*) name;
-(void) removeEmailAddress: (NSString*) name;
-(NSString*) getNameAtIndex: (NSInteger) index;
-(NSString*) getEmailAtIndex: (NSInteger) index;
-(NSInteger) emailCount;
-(void) getStoredEmailSettings;
-(void) updateStoredEmailSettings;
-(NSArray*) getMailingList;
-(void) removeEntryAtIndex: (NSInteger) index;
-(NSString*) getEmailSubject;
-(NSString*) getEmailMessageBody;

@end
