//
//  RemoveDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/12/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "RemoveDeviceData.h"

@implementation RemoveDeviceData


-(NSString*) getEmailMessageBody {
 
    NSMutableString *buffer = [NSMutableString stringWithFormat:@"<b>Device name:</b> %@<br/><b>Building:</b> %@<br/><b>Closet:</b> %@<br/>", [self getDeviceName], [self building], [self closet]];
    [buffer appendFormat:@"<b>Tag number:</b> %@<br/>", [self tag]];
    [buffer appendFormat:@"%@ is a %@.<br/>", [self getDeviceName], [self getDeviceTypeString]];
    [buffer appendFormat:@"\nComments:\n%@", [super comments]];
    return [buffer copy];
}

-(NSString*) getEmailSubject {
    
    NSString *buffer = [NSString stringWithFormat:@"Removed %@ tag# %@ from building %@ closet %@", [self getDeviceTypeString], [self tag], [self building], [self closet]];
    return [buffer copy];
}

-(BOOL) isFormFilledOut {
    
    bool result = true;
    if ([[self tag] length] == 0) {
        result = false;
    }
    if ([[self building] length] == 0) {
        result = false;
    }
    if ([[self closet] length] == 0) {
        result = false;
    }
    if ([self deviceType] == UNDEFINED) {
        result = false;
    }
    return result;
}
@end
