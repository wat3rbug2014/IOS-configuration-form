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
        items = [NSArray arrayWithObjects:@"Access Switch", @"UPS", @"Access Point", @"Distribution Switch", @"Access Router", nil];
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
