//
//  ConfigurationData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "enumList.h"

@interface ConfigurationData : NSObject

@property (retain) NSString *building;
@property(retain) NSString *closet;
@property (retain) NSString *currentUplinkOne;
@property (retain) NSString *currentUplinkTwo;
@property (retain) NSString *currentTag;
@property (retain) NSString *oldTag;
@property (retain) NSString *oldUplinkOne;
@property (retain) NSString *oldUplinkTwo;
@property (retain) NSString *oldIp;
@property (retain) NSString *currentIp;
@property (retain) NSString *vlan;
@property (retain) NSString *destTagOne;
@property (retain) NSString *destTagTwo;

@property int deviceType;
@property int site;

@property (retain) NSMutableDictionary *emailAddresses;
@property (retain) NSArray *nameArray;
@property (retain) NSArray *emailArray;

-(NSString*) getOldDeviceName;
-(NSString*) getNewDeviceName;
-(NSString*) getDeviceTypeString;
-(NSString*) getSiteString;
-(NSString*) getSiteAbbreviatedString;

// email methods

-(void) addEmailAddress: (NSString*) email withName: (NSString*) name;
-(void) removeEmailAddress: (NSString*) name;
-(NSString*) getNameAtIndex: (NSInteger) index;
-(NSString*) getEmailAtIndex: (NSInteger) index;
-(NSInteger) emailCount;
-(void) updateStoredEmailSettings;
-(NSArray*) getMailingList;

-(BOOL) isFormFilledOutForType: (NSInteger) formType;
-(void) clear;

@end
