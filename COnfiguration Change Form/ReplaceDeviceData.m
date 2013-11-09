//
//  ReplaceDeviceData.m
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/8/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ReplaceDeviceData.h"

@implementation ReplaceDeviceData

@synthesize oldTag;

-(BOOL) isFormFilledOut {
    
    BOOL result = [super isFormFilledOut];
    if ([oldTag length] == 0) {
        result = false;
    }
    return result;
}

-(void) setNewTag: (NSString*) newTag {
    
    [super setTag:newTag];
}
-(NSString*) newTag {
    
    return [super tag];
}

-(NSString*) getEmailMessageBody {
    
    NSMutableString *buffer = [NSMutableString stringWithString:[super getEmailMessageBody]];
    [buffer appendFormat:@"The old tag# was %@ and the new tag is %@\n.", [self oldTag], [super tag]];
    return buffer;
}

-(NSString*) getEmailSubject {
    
    return[NSString stringWithFormat:@"%@ replaced tag #%@", [super getEmailSubject], [self oldTag]];
}

@end