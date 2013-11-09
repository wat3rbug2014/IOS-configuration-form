//
//  ConfigurationData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationDataProtocol.h"
#import "enumList.h"

@interface ConfigurationData : NSObject 

@property (retain) NSString *building;
@property(retain) NSString *closet;
@property (retain) NSString *tag;
@property (retain) NSString *ipAddress;
@property NSInteger vlan;
@property (retain) NSString *comments;

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
