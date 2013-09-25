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

-(id) init {
    
    self = [super init];
    if (self != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [self setEmailAddresses:[NSMutableArray arrayWithArray:[defaults objectForKey:emailKey]]];
    }
    return self;
}

-(int) deviceType {
    
    return self.deviceType;
}
-(void)setDeviceType:(int)deviceType {
    
    // watch for fall through because of the use of enum when iterating.
    
    for (int i = UNDEFINED; i < AR; i++) {
        if (deviceType == i) {
            self.deviceType = deviceType;
        }
    }
}

-(int) site {
    
    return self.site;
}
-(void) setSite:(int)site {
    
    // watch for fall through because of the use of enum when iterating.
    
    for (int i = JSC; i < LARC; i++) {
        if (site == i) {
            self.site = site;
        }
    }
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

-(NSString*) getMailingList {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    for (NSString *currentEmail in emailAddresses) {
        [buffer stringByAppendingString:@","];
        [buffer stringByAppendingString:currentEmail];
    }
    return buffer;
}

-(void) addEmailAddress: (NSString*) email {
    
    [emailAddresses addObject:email];
    [self updateStoredEmailSettings];
    
}

-(void) removeEmailAddress: (NSString*) email{
    
    [emailAddresses removeObject:email];
    [self updateStoredEmailSettings];
}

-(NSString*) getDeviceTypeString {
    
#warning not all cases defined
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

-(NSString*) getSiteString {
    
#warning not all cases defined
    
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
    
#warning not all cases defined
    
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

-(int) emailCount {
    
    return [emailAddresses count];
}

-(void) updateStoredEmailSettings {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:emailAddresses forKey:emailKey];
    [defaults synchronize];
    defaults = nil;
}
@end
