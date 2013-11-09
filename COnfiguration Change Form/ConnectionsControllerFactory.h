//
//  ConnectionsControllerFactory.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/9/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionsController.h"

@interface ConnectionsControllerFactory : NSObject

-(ConnectionsController*) createConnectionsController: (int) formType;

@end
