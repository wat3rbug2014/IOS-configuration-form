//
//  ConfigurationDataFactory.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "enumList.h"

@interface ConfigurationDataFactory : NSObject

+(id) create: (int) formType;

@end
