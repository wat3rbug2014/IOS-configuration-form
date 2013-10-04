//
//  ConfigurationData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConfigurationData.h"

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
@synthesize oldUplinkOne;
@synthesize oldUplinkTwo;
@synthesize emailAddresses;
@synthesize emailArray;
@synthesize nameArray;
@synthesize destTagOne;
@synthesize destTagTwo;
@synthesize vlan;

#pragma mark -
#pragma mark initialization methods

-(id) init {
    
    self = [super init];
    if (self != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [self setEmailAddresses:[NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:emailKey]]];
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
    oldUplinkOne = nil;
    oldUplinkTwo = nil;
    oldIp = nil;
    currentIp = nil;
    vlan = nil;
    destTagOne = nil;
    destTagTwo = nil;
}
-(int) deviceType {
    
    return self.deviceType;
}

-(NSString*) getDeviceTypeString {
    
    // this should be written better. I don't like switch stuff
    NSString *deviceTypeString;
    switch ([self deviceType]) {
        case AS: {
            deviceTypeString = @"Access Switch";
            break;
        }
        case AR: {
            deviceTypeString = @"Distribution Router";
            break;
        }
        case UP: {
            deviceTypeString =@"UPS";
            break;
        }
        default: {
            deviceTypeString = @"Undefined";
        }
    }
    return deviceTypeString;
}

-(NSString*) getNewDeviceName {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    [buffer stringByAppendingString:[self getSiteAbbreviatedString]];
    [buffer stringByAppendingString: @"-"];
    [buffer stringByAppendingString:[self getDeviceTypeString]];
    [buffer stringByAppendingString:@"-"];
    [buffer stringByAppendingString:[self building]];
    [buffer stringByAppendingString:@"-"];
    [buffer stringByAppendingString:[self closet]];
    [buffer stringByAppendingString:@"-"];
    [buffer stringByAppendingString:[self currentTag]];
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

-(int) site {
    
    return self.site;
}

-(void)setDeviceType:(int)deviceType {
    
    // watch for fall through because of the use of enum when iterating.
    
    for (int i = UNDEFINED; i < AR; i++) {
        if (deviceType == i) {
            self.deviceType = deviceType;
        }
    }
}

-(void) setSite:(int)site {
    
    // watch for fall through because of the use of enum when iterating.
    
    for (int i = JSC; i < LARC; i++) {
        if (site == i) {
            self.site = site;
        }
    }
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

-(BOOL) isFormFilledOutForType: (NSInteger) formType {
    
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
    return result;
}

#pragma mark -
#pragma Email methods

-(void) addEmailAddress: (NSString*) email withName: (NSString*) name {
    
    [emailAddresses addEntriesFromDictionary:[NSDictionary dictionaryWithObject:email forKey:name]];
    [self updateStoredEmailSettings];
    
}

-(NSArray*) getMailingList {
    
    emailArray = [emailAddresses allValues];
    return emailArray;
}

-(void) removeEmailAddress: (NSString*) name{
    
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

-(void) updateStoredEmailSettings {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emailAddresses forKey:emailKey];
    [defaults synchronize];
    defaults = nil;
}

@end
