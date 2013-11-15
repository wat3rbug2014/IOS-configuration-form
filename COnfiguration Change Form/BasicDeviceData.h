//
//  RemoveDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/12/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationDataProtocol.h"
#import "enumList.h"

@interface BasicDeviceData : NSObject <ConfigurationDataProtocol>

@property (retain) NSString *building;
@property(retain) NSString *closet;
@property (retain) NSString *tag;
@property (retain) NSString *ipAddress;
@property NSInteger vlan;
@property (retain) NSString *comments;
@property NSInteger deviceType;
@property NSInteger site;

@property (retain) NSMutableDictionary *emailAddresses;
@property (retain) NSArray *nameArray;
@property (retain) NSArray *emailArray;

@end
