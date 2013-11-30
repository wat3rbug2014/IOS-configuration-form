//
//  AlterDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/30/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AlterDeviceData.h"

@implementation AlterDeviceData


-(NSString*) getEmailSubject {
    
    return[NSString stringWithFormat:@"Altered the configuration for tag# %@ to building %@ closet %@",
           [self tag], [self building], [self closet]];
}
@end
