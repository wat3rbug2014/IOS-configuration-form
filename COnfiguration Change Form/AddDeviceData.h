//
//  AddDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "BasicConfigData.h"
#import "ConfigurationDataProtocol.h"

@interface AddDeviceData : BasicConfigData

@property (retain) NSString* uplinkOneFrom;
@property (retain) NSString* upLinkOneTo;
@property (retain) NSString* destOneTag;
@property (retain) NSString* uplinkTwoFrom;
@property (retain) NSString* uplinkTwoTo;
@property (retain) NSString* destTwoTag;

@end
