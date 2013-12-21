//
//  AddDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "BasicDeviceData.h"
#import "ConfigurationDataProtocol.h"

@interface AddDeviceData : BasicDeviceData

@property (retain) NSString* uplinkOneFrom;
@property (retain) NSString* uplinkOneTo;
@property (retain) NSString* destOneTag;
@property (retain) NSString* uplinkTwoFrom;
@property (retain) NSString* uplinkTwoTo;
@property (retain) NSString* destTwoTag;

@end
