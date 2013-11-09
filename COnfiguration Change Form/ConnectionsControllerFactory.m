//
//  ConnectionsControllerFactory.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/9/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConnectionsControllerFactory.h"

@implementation ConnectionsControllerFactory

+(ConnectionsController*) createConnectionsController: (int) formType {
    
    switch (formType) {
        case ADD: return [[ConnectionsController alloc] init];
            break;
        default: return [[ConnectionsController alloc] init];
            break;
        
    }
}

@end
