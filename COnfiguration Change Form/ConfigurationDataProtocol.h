//
//  ConfigurationDataProtocol.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/7/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConfigurationDataProtocol <NSObject>

@required
-(NSString*) getDeviceName;
-(NSString*) getMessageBodyForConnectionType:(NSInteger)formType;
-(NSString*) getSubjectForConnectionType: (NSInteger) formType;
-(BOOL) isFormFilledOut;

@end
