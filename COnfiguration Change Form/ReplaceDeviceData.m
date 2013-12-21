//
//  ReplaceDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/8/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ReplaceDeviceData.h"

@implementation ReplaceDeviceData

@synthesize oldTag;

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
    if ([[self oldTag] length] == 0) {
        result = false;
    }
    return result;
}

-(void) setCurrentTag: (NSString*) newTag {
    
    [super setTag:newTag];
}
-(NSString*) currentTag {
    
    return [super tag];
}

-(NSString*) getEmailMessageBody {
    
    NSMutableString *buffer = [NSMutableString stringWithFormat:@"<b>Device name:</b> %@<br/><b>Building:</b> %@<br/><b>Closet:</b> %@<br/>", [super getDeviceName], [super building], [super closet]];
    [buffer appendFormat:@"The old tag# was %@ and the new tag is %@\n.", [self oldTag], [super tag]];
    return [buffer copy];
}

-(NSString*) getEmailSubject {
    
    return [NSString stringWithFormat:@"Replaced tag# %@  with tag# %@ for %@ in building %@ closet %@", [super tag], [self oldTag],[super getDeviceTypeString], [super building], [super closet]];
}

@end
