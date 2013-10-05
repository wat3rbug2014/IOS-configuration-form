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

-(id) init {
    
    self = [super init];
    if (self != nil) {
        items = [NSArray arrayWithObjects:@"Aggregation Device", @"Access Point", @"Access-Layer-Router", @"Access-Layer Switch",
                 @"Border Router", @"Call Manager", @"Core Switch", @"Core Router", @"Distribution Switch", @"Distribution Router",
                 @"Firewall", @"Load Balancer", @"NAM Module", @"Power Distribution Unit", @"Power Strip", @"Proxy", @"UPS",
                 @"VPN Controller", @"Wireless Controller", nil];
    }
    return self;
}

-(NSInteger) count {
    
    return [items count];
}
-(NSString*) deviceAtIndex:(NSInteger)index {
    
    if (index < 0 || index == [items count]) {
        return [items objectAtIndex:0];
    }
    return [items objectAtIndex:index];
}
@end