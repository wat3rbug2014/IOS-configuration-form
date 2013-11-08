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
@synthesize ipAddress;
@synthesize tag;
@synthesize emailAddresses;
@synthesize emailArray;
@synthesize nameArray;
@synthesize site;
@synthesize deviceType;
@synthesize isReadyToSend;
@synthesize comments;

#pragma mark -
#pragma mark initialization methods

-(id) init {
    
    self = [super init];
    if (self != nil) {
        [self getStoredEmailSettings];

    }
    return self;
}

-(NSInteger) vlan {
    
    return self.vlan;
}

-(void) setVlan:(NSInteger)newVlan {
    
    if (newVlan > [[NSNumber numberWithInt:0] integerValue] &&  newVlan < [[NSNumber numberWithInt:9999] integerValue]) {
        self.vlan = newVlan;
    }
}
-(void) clear {
    
    // can i do this with new object and dismiss self and copy email over?
    
    building = nil;
    closet = nil;
    tag = nil;
    ipAddress = nil;
}

-(NSString*) getAbbreviateDeviceString {
    
    PickerItems *deviceTypes = [[PickerItems alloc] init];
    return [deviceTypes getAbbreviatedDeviceString:[self deviceType]];
}

-(NSString*) getDeviceTypeString {
    
    PickerItems *deviceNames = [[PickerItems alloc] init];
    return [deviceNames deviceAtIndex:[self deviceType]];
}

-(NSString*) getDeviceName {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    [buffer appendFormat:@"%@-%@-%@-%@-%@", [self getSiteAbbreviatedString], [self getAbbreviateDeviceString], [self building], [self closet], [self tag]];
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

-(BOOL) isFormFilledOut {
    
    BOOL result = true;
    
    // make list on checks so easier to add if needed.
    
    if ([tag length] == 0) {
        result = false;
    }
    if ([closet length] == 0) {
        result = false;
    }
    if ([ipAddress length] == 0) {
        result = false;
    }
    if (self.vlan == [[NSNumber numberWithInt:0] integerValue]) {
        result = false;
    }
    return result;
}


@end
