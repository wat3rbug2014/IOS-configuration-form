//
//  RemoveDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/12/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "BasicDeviceData.h"
#import "PickerItems.h"

static NSString *const emailKey = @"ConfigChanger.Email";

@implementation BasicDeviceData

@synthesize building;
@synthesize closet;
@synthesize tag;
@synthesize ipAddress;
@synthesize vlan = _vlan;
@synthesize comments;
@synthesize deviceType;
@synthesize emailAddresses;
@synthesize nameArray;
@synthesize emailArray;

#pragma mark -
#pragma mark initialization methods

-(id) init {
    
    self = [super init];
    if (self != nil) {
        [self getStoredEmailSettings];
        
    }
    return self;
}

-(void) setCurrentTag: (NSString*) newTag {
    
    [self setTag:newTag];
}

-(NSString*) currentTag {
    
    return [self tag];
}

-(void) setOldTag: (NSString*) newTag {
    
    [self setTag:newTag];
}

-(NSString*) oldTag {
    
    return [self tag];
}

-(NSInteger) vlan {
    
    return _vlan;
}

-(void) setVlan:(NSInteger)newVlan {
    
    if (newVlan > [[NSNumber numberWithInt:0] integerValue] &&  newVlan < [[NSNumber numberWithInt:9999] integerValue]) {
        _vlan = newVlan;
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

-(NSString*) getEmailMessageBody {
    
    NSMutableString *buffer = [NSMutableString stringWithFormat:@"Device name: %@\nBuilding: %@\nCloset: %@\n", [self getDeviceName], [self building], [self closet]];
    [buffer appendFormat:@"Tag number: %@\nIP Address: %@\nVLAN: %@", [self tag], [self ipAddress], [[NSNumber numberWithInteger:[self vlan]] stringValue]];
    [buffer appendFormat:@"%@ is a %@.\n", [self getDeviceName], [self getDeviceTypeString]];
    return buffer;
}

-(NSString*) getEmailSubject {
    
    NSString *buffer = [NSString stringWithFormat:@"%@ tag# %@ to building %@ closet %@", [self getDeviceTypeString], [self tag], [self building], [self closet]];
    return buffer;
}

@end
