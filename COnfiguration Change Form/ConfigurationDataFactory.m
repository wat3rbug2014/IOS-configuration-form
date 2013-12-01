//
//  ConfigurationDataFactory.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConfigurationDataFactory.h"
#import "AddDeviceData.h"
#import "ReplaceDeviceData.h"
#import "RemoveDeviceData.h"
#import "ChangeDeviceData.h"
#import "AlterDeviceData.h"

@implementation ConfigurationDataFactory


+(id) create:(int)formType {
    
    id result = nil;
    switch (formType) {
        case ADD: result = [[AddDeviceData alloc] init];
            break;
        case REMOVE: result = [[RemoveDeviceData alloc] init];
            break;
        case REPLACE: result = [[ReplaceDeviceData alloc] init];
            break;
        default: result = [[AlterDeviceData alloc] init];
            break;
    }
    return result;
}
@end
