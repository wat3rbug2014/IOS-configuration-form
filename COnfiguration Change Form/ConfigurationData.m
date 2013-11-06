//
//  ConfigurationData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConfigurationData.h"
#import "PickerItems.h"

static NSString *const emailKey = @"ConfigChanger.Email";

@implementation ConfigurationData

@synthesize building;
@synthesize closet;
@synthesize currentIp;
@synthesize oldIp;
@synthesize currentTag;
@synthesize oldTag;
@synthesize currentUplinkOne;
@synthesize currentUplinkTwo;
@synthesize emailAddresses;
@synthesize emailArray;
@synthesize nameArray;
@synthesize destTagOne;
@synthesize destTagTwo;
@synthesize vlan;
@synthesize site;
@synthesize deviceType;
@synthesize destPortOne;
@synthesize destPortTwo;
@dynamic isReadyToSend;

#pragma mark -
#pragma mark initialization methods

-(id) init {
    
    self = [super init];
    if (self != nil) {
        [self getStoredEmailSettings];
        [self setIsReadyToSend:false];
    }
    return self;
}

-(void) clear {
    
    // can i do this with new object and dismiss self and copy email over?
    
    building = nil;
    closet = nil;
    currentUplinkOne = nil;
    currentUplinkTwo = nil;
    currentTag = nil;
    oldTag = nil;
    oldIp = nil;
    currentIp = nil;
    vlan = nil;
    destTagOne = nil;
    destTagTwo = nil;
}

-(NSString*) getAbbreviateDeviceString {
    
    PickerItems *deviceTypes = [[PickerItems alloc] init];
    return [deviceTypes getAbbreviatedDeviceString:[self deviceType]];
}

-(NSString*) getDeviceTypeString {
    
    PickerItems *deviceNames = [[PickerItems alloc] init];
    return [deviceNames deviceAtIndex:[self deviceType]];
}

-(NSString*) getNewDeviceName {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    [buffer appendFormat:@"%@-%@-%@-%@-%@", [self getSiteAbbreviatedString], [self getAbbreviateDeviceString], [self building], [self closet], [self currentTag]];
    return buffer;
}

-(NSString*) getOldDeviceName {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    [buffer stringByAppendingString:[self getSiteAbbreviatedString]];
    [buffer stringByAppendingString: @"-"];
    [buffer stringByAppendingString:[self getDeviceTypeString]];
    [buffer stringByAppendingString:@"-"];
    [buffer stringByAppendingString:[self building]];
    [buffer stringByAppendingString:@"-"];
    [buffer stringByAppendingString:[self closet]];
    [buffer stringByAppendingString:@"-"];
    [buffer stringByAppendingString:[self oldTag]];
    return buffer;
}

-(NSString*) getSiteString {
    
    NSString *siteName;
    switch ([self site]) {
        case LARC: {
            siteName =@"LARC";
            break;
        }
        default: {
            siteName = @"JSC";
            break;
        }
    }
    return siteName;
}

-(NSString*) getSiteAbbreviatedString {
    
    NSString *siteName;
    switch ([self site]) {
        case LARC: {
            siteName =@"AR";
            break;
        }
        default: {
            siteName = @"JS";
            break;
        }
    }
    return siteName;
}

-(void) isFormFilledOutForType: (NSInteger) formType {
    
    BOOL result = YES;
    if ([self building] == nil|| [self closet] == nil || [self vlan] == nil) {
        result = NO;
    }
    if (formType == ADD || formType == BOTH) {
        if ([self currentUplinkOne] == nil|| [self currentTag] == nil || [self currentIp] == nil || [self destTagOne] == nil) {
            result = NO;
        }
    }
    if (formType == REMOVE) {
        if ([self oldTag] == nil|| [self oldIp] == nil) {
            result = NO;
        }
    }
    [self setIsReadyToSend:result];
}

#pragma mark -
#pragma Email methods

-(void) addEmailAddress: (NSString*) email withName: (NSString*) name {
    
    [emailAddresses addEntriesFromDictionary:[NSDictionary dictionaryWithObject:email forKey:name]];
    [self updateStoredEmailSettings];
    nameArray = [emailAddresses allKeys];
    emailArray = [emailAddresses allValues];
    
}

-(NSArray*) getMailingList {
    
    [self getStoredEmailSettings];
    emailArray = [emailAddresses allValues];
    return emailArray;
}

-(void) removeEmailAddress: (NSString*) name {
    
    [emailAddresses removeObjectForKey:name];
    [self updateStoredEmailSettings];
}

-(NSInteger) emailCount {
    
    emailArray = [emailAddresses allValues];
    return [emailArray count];
}
-(NSString*) getEmailAtIndex:(NSInteger)index {
    
    emailArray = [emailAddresses allValues];
    return [emailArray objectAtIndex:index];
    
}

-(NSString*) getNameAtIndex:(NSInteger)index {
    
    nameArray = [emailAddresses allKeys];
    return [nameArray objectAtIndex:index];
}

-(void) getStoredEmailSettings {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self setEmailAddresses:[NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:emailKey]]];
}
-(void) updateStoredEmailSettings {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emailAddresses forKey:emailKey];
    [defaults synchronize];
    defaults = nil;
}

-(void) removeEntryAtIndex:(NSInteger)index {
    
    NSString *emailToRemove = [nameArray objectAtIndex:index];
    [emailAddresses removeObjectForKey:emailToRemove];
    [self updateStoredEmailSettings];
}

-(NSString*) getMessageBodyForConnectionType:(NSInteger)formType {
    
    NSMutableString *result;
    result = [NSMutableString stringWithFormat:@"Location: %@ closet %@\n", [self building], [self closet]];
    
    // add form body
    
    if (formType == ADD) {
        [result appendFormat:@"tag# %@ is device type %@.\n", [self currentTag], [self getDeviceTypeString]];
        [result appendFormat:@"tag #%@ is on vlan %@ with address %@.\n", [self currentTag], [self vlan], [self currentIp]];
        [result appendFormat:@"tag# %@ port %@ is connected to %@ on port %@.\n", [self currentTag], [self currentUplinkOne], [self destTagOne], [self destPortOne]];
        if ([self currentUplinkTwo] != nil) {
            [result appendFormat:@"tag# %@ port %@ is also connected to %@ on port %@.\n", [self currentTag], [self currentUplinkTwo], [self destTagOne], [self destPortTwo]];
        }
    }
    // remove form body
    
    if (formType == REMOVE) {
        [result appendFormat:@"tag# %@ was device type %@.\n", [self oldTag], [self getDeviceTypeString]];
        [result appendFormat:@"tag #%@ was on vlan %@ with address %@.\n", [self oldTag], [self vlan], [self oldIp]];
    }
    // change form body
    
    if (formType == BOTH) {
        [result appendFormat:@"tag# %@ was device type %@.\n", [self currentTag], [self getDeviceTypeString]];
        if ([self oldIp] != nil && [self currentIp] != nil) {
            [result appendFormat:@"IP addresses changed from %@ to %@.\n", [self oldIp], [self currentIp]];
        }
        if ([self oldTag] != nil && [self currentTag] != nil) {
            [result appendFormat:@"tags changed from %@ to %@.\n", [self oldTag], [self currentTag]];
        }
        [result appendFormat:@"tag# %@ port %@ is connected to %@ on port %@.\n", [self currentTag], [self currentUplinkOne], [self destTagOne], [self destPortOne]];
        if ([self currentUplinkTwo] != nil) {
            [result appendFormat:@"tag# %@ port %@ is also connected to %@ on port %@.\n", [self currentTag], [self currentUplinkTwo], [self destTagOne], [self destPortTwo]];
        }
    }
    return result;
}

-(NSString*) getSubjectForConnectionType: (NSInteger) formType {
    
    NSString *result;
    switch (formType) {
        case ADD: {
            result = [NSString stringWithFormat:@"Added %@", [self getNewDeviceName]];
            break;
        }
        case REMOVE: {
            result = [NSString stringWithFormat:@"Removed %@", [self getNewDeviceName]];
            break;
        }
        case BOTH: {
            if([self oldTag] != nil) {
                result = [NSString stringWithFormat:@"Changed %@", [self getOldDeviceName]];
            } else {
                result = [NSString stringWithFormat:@"Changed %@", [self getNewDeviceName]];
            }
        }
    }
    return result;
}
@end
