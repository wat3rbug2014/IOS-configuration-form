//
//  AddDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "AddDeviceData.h"

@implementation AddDeviceData


-(NSString*) getEMailMessageBody {
    
    
    return @"";
}
-(NSString*) getEMailSubject {
  
    return @"";
}

-(BOOL) isFormFilledOut {
    
    BOOL result;
    result = [super isFormFilledOut];
    
    // need the uplink stuff
    
    return result;
}

@end
