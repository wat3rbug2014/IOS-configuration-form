//
//  AddDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AddDeviceData.h"

@implementation AddDeviceData


@synthesize uplinkOneFrom;
@synthesize upLinkOneTo;
@synthesize destOneTag;
@synthesize uplinkTwoFrom;
@synthesize uplinkTwoTo;
@synthesize destTwoTag;

-(BOOL) isFormFilledOut {
    
    BOOL result;
    result = [super isFormFilledOut];
    
    if ([uplinkOneFrom length] == 0) {
        result = false;
    }
    if ([upLinkOneTo length] == 0) {
        result = false;
    }
    if ([destOneTag length] == 0) {
        result = false;
    }
    return result;
}

-(NSString*) getEmailMessageBody {
    
    NSMutableString *buffer = [NSMutableString stringWithFormat:@"%@ added to the network.\n", [super getDeviceTypeString]];
    [buffer appendFormat:@"Device name: %@\nBuilding: %@\nCloset: %@\n", [super getDeviceName], [super building], [super closet]];
    [buffer appendFormat:@"Tag number: %@\nIP Address: %@\nVLAN: %@", [super tag], [super ipAddress], [[NSNumber numberWithInteger:[super vlan]] stringValue]];
    [buffer appendFormat:@"%@ is a %@.\n", [super getDeviceName], [super getDeviceTypeString]];
    [buffer appendFormat:@"The first uplink on port %@ of %@ connects to port %@ of the device with tag# %@\n", [self uplinkOneFrom],
     [super getDeviceName], [self upLinkOneTo], [self destOneTag]];
    if ([uplinkTwoFrom length] > 0 && [uplinkTwoTo length] > 0 && [destTwoTag length] > 0) {
        [buffer appendFormat:@"The second uplink on port %@ of %@ connects to port %@ of the device with tag# %@\n", [self uplinkTwoFrom],
         [super getDeviceName], [self uplinkTwoTo], [self destTwoTag]];
    }
    if ([[super comments] length] > 0) {
        [buffer appendFormat:@"Comments:\n%@", [super comments]];
    }
    return buffer;
}

-(NSString*) getEmailSubject {

    NSMutableString *buffer = [NSMutableString stringWithString:@"Added "];
    [buffer appendFormat:@"%@ tag# %@ to building %@ closet %@", [super getDeviceTypeString], [super tag], [super building], [super closet]];
    return buffer;
}

@end
