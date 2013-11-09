//
//  ReplaceDeviceData.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/8/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import "ConfigurationData.h"

@interface ReplaceDeviceData : ConfigurationData

@property (retain) NSString *oldTag;

-(void) setCurrentTag: (NSString*) currentTag;
-(NSString*) currentTag;

@end
