//
//  ConfigurationData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConfigurationData.h"

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

-(int) deviceType {
    
    return self.deviceType;
}
-(void)setDeviceType:(int)deviceType {
    
    // go through enum and check if deviceType matches and write if it does
    self.deviceType = deviceType;
}

-(int) site {
    
    return self.site;
}
-(void) setSite:(int)site {
    
    // go through enum and check available site
    self.site = site;
}
-(NSString*) getOldDeviceName {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    
    // build the name by the convention
    
    return buffer;
}
-(NSString*) getNewDeviceName {
    
    NSMutableString *buffer = [[NSMutableString alloc] init];
    
    // build the name by the convention
    
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
}
-(void) removeEmailAddress: (NSString*) email{
    
    [emailAddresses removeObject:email];
}
-(NSString*) getDeviceTypeString:(int)device {
    
    // this should be written better. I don't like switch stuff
    NSString *deviceTypeString;
    switch (device) {
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
@end
