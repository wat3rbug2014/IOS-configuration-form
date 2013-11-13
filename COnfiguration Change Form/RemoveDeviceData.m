//
//  RemoveDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/12/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "RemoveDeviceData.h"

@implementation RemoveDeviceData


-(NSString*) getEmailMessageBody {
 
    NSMutableString *buffer = [NSMutableString stringWithString:[super getEmailMessageBody]];
    [buffer appendFormat:@"\nComments:\n%@", [super comments]];
    return [buffer copy];
}

-(NSString*) getEmailSubject {
    
    return [NSString stringWithFormat:@"Removed %@", [super getEmailSubject]];
}
@end
