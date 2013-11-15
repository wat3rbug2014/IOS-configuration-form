//
//  ConfigurationDataProtocol.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConfigurationDataProtocol <NSObject>

@required

-(NSString*) getEmailMessageBody;
-(NSString*) getEmailSubject;
-(BOOL) isFormFilledOut;
-(void) setTag: (NSString*) currentTag;
-(NSString*) tag;
-(NSString*) getDeviceName;
-(NSString*) getDeviceTypeString;
-(NSString*) getSiteString;
-(NSString*) getSiteAbbreviatedString;
-(NSString*) getAbbreviateDeviceString;
-(void) clear;

-(void) addEmailAddress: (NSString*) email withName: (NSString*) name;
-(void) removeEmailAddress: (NSString*) name;
-(NSString*) getNameAtIndex: (NSInteger) index;
-(NSString*) getEmailAtIndex: (NSInteger) index;
-(NSInteger) emailCount;
-(void) getStoredEmailSettings;
-(void) updateStoredEmailSettings;
-(NSArray*) getMailingList;
-(void) removeEntryAtIndex: (NSInteger) index;


@optional


@end
