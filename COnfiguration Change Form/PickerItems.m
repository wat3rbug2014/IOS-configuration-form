//
//  PickerItems.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/1/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "PickerItems.h"

@implementation PickerItems


@synthesize items;
@synthesize deviceAbbr;

-(id) init {
    
    self = [super init];
    if (self != nil) {
        items = [NSArray arrayWithObjects:@"Unknown",
                 @"Aggregation Device",
                 @"Access Point",
                 @"Access-Layer-Router",
                 @"Access-Layer Switch",
                 @"Border Router",
                 @"Call Manager",
                 @"Core Switch",
                 @"Core Router",
                 @"Distribution Switch",
                 @"Distribution Router",
                 @"Firewall",
                 @"Load Balancer",
                 @"NAM Module",
                 @"Power Distribution Unit",
                 @"Power Strip",
                 @"Proxy", @"UPS",
                 @"VPN Controller",
                 @"Wireless Controller",
                 @"Voice Gateway",
                 @"Wireless Bridge", nil];
        deviceAbbr = [NSArray arrayWithObjects:@"unknown",
                      @"ad",
                      @"ap",
                      @"ar",
                      @"as",
                      @"br",
                      @"cm",
                      @"cs",
                      @"cr",
                      @"ds",
                      @"dr",
                      @"fw",
                      @"lb",
                      @"nm",
                      @"pd",
                      @"ps",
                      @"pr",
                      @"up",
                      @"vc",
                      @"wc",
                      @"vg",
                      @"wb", nil];
    }
    return self;
}
-(NSString*) getAbbreviatedDeviceString: (NSInteger) device {
    
    if (device < 0 || device >= [items count]) {
        return @"as";
    } else {
        return [deviceAbbr objectAtIndex:device];
    }
}

-(NSInteger) count {
    
    return [items count];
}
-(NSString*) deviceAtIndex:(NSInteger)index {
    
    if (index < 0 || index >= [items count]) {
        return [items objectAtIndex:0];
    }
    return [items objectAtIndex:index];
}

@end
