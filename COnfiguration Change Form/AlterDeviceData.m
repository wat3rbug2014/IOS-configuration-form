//
//  AlterDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/30/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AlterDeviceData.h"

@implementation AlterDeviceData


-(NSString*) getEmailSubject {
    
    return[NSString stringWithFormat:@"Altered the configuration for %@",
           [self getDeviceName]];
}

-(BOOL) isFormFilledOut {
    
    // basic information about device
    
    BOOL result = true;
    BOOL isAltered = false;
    if([[super tag] length] == 0) {
        result = false;
    }
    if ([[super building] length] == 0) {
        result = false;
    }
    if ([[super closet] length] == 0) {
        result = false;
    }
    if ([self deviceType] == UNDEFINED) {
        result = false;
    }
    // check to see that some kind of connection is different
    
    if ([[super uplinkOneTo] length] > 0 || [[super uplinkOneFrom] length] > 0 || [[super destOneTag] length] > 0) {
        isAltered = true;
        if ([[super uplinkOneTo] length] <= 0 || [[super uplinkOneFrom] length] <= 0 || [[super destOneTag] length] <= 0) {
            result = false;
        }
    }
    if ([[super uplinkTwoTo] length] > 0 || [[super uplinkTwoFrom] length] > 0 || [[super destTwoTag] length] > 0) {
        isAltered = true;
        if ([[super uplinkTwoTo] length] <= 0 || [[super uplinkTwoFrom] length] <= 0 || [[super destTwoTag] length] <= 0) {
            result = false;
        }
    }
    // if vlan is different the IP address has to be different.
        
    if ([super vlan] > 0) {
        isAltered = true;
        if ([[super ipAddress] length] == 0) {
            result = false;
        }
    }
    if ([[super ipAddress] length] > 0) {
        isAltered = true;
    }
    return result && isAltered;
}

-(NSString*) getEmailMessageBody {
    
    NSMutableString *buffer = [NSMutableString stringWithFormat:@"<b>Tag:</b> %@</br><b>Building:</b> %@</br>", [self tag], [self building]];
    [buffer appendFormat:@"<b>Closet:</b> %@</br><b>Device Type:</b> %@</br><p>", [self closet],[self getDeviceTypeString]];
    if ([[self uplinkOneTo] length] > 0) {
        [buffer appendFormat:@"Now uplink 1 goes from port %@ to port %@ on device tag# %@</br>", [self uplinkOneFrom], [self uplinkOneTo], [self destOneTag]];
    }
    if ([[self uplinkTwoTo] length] > 0) {
        [buffer appendFormat:@"Now uplink 2 goes from port %@ to port %@ on device tag# %@</br>", [self uplinkTwoFrom], [self uplinkTwoTo], [self destTwoTag]];
    }
    if ([self vlan] > 0) {
        [buffer appendFormat:@"VLAN changed to %ld with IP address: %@</br>", (long)[self vlan], [self ipAddress]];
    } else {
        if ([[self ipAddress] length] > 0) {
            [buffer appendFormat:@"The IP address changed to %@</br></p>", [self ipAddress]];
        }
    }
    if ([[super comments] length] > 0) {
        [buffer appendFormat:@"<p></p><b>Comments:</b><br/>%@", [super comments]];
    }
    return [buffer copy];
}
@end
