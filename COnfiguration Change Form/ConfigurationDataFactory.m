//
//  ConfigurationDataFactory.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConfigurationDataFactory.h"
#import "AddDeviceData.h"
#import "RemoveDeviceData.h"
#import "ReplaceDeviceData.h"

@implementation ConfigurationDataFactory


+(id) create:(int)formType {
    
    switch (formType) {
        case ADD: return [[AddDeviceData alloc] init];
            break;
        case REMOVE: return [[RemoveDeviceData alloc] init];
            break;
        case REPLACE: return [[ReplaceDeviceData alloc] init];
            break;
        default: return [[ConfigurationData alloc] init];
            break;
    }
}
@end