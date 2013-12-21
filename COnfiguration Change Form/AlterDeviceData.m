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
    
    return[NSString stringWithFormat:@"Altered the configuration for tag# %@ to building %@ closet %@",
           [self tag], [self building], [self closet]];
}

-(BOOL) isFormFilledOut {
    
    // basic information about device
    
    BOOL result = true;;
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
    
    if ([[super upLinkOneTo] length] > 0 || [super vlan] > 0 || [[super uplinkTwoTo] length] > 0) {
        
        // check for complete uplink 1 info
        
        if ([[super upLinkOneTo] length] > 0) {
            if ([[super uplinkOneFrom] length] == 0 || [[super destOneTag] length] == 0) {
                result = false;
            }
        }
        
        // check for complete uplink 2 info
        
        if ([[super uplinkTwoTo] length] > 0) {
            if ([[super uplinkTwoFrom] length] == 0 || [[super destTwoTag] length] == 0) {
                result = false;
            }
        }
        // if vlan is different the IP address has to be different.
        
        if ([super vlan] > 0) {
            if ([[super ipAddress] length] == 0) {
                result = false;
            }
        }
    }
    return result;
}
@end
