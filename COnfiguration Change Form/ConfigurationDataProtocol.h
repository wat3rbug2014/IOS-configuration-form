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

-(NSString*) getEmailMessageBody;
-(NSString*) getEmailSubject;
-(BOOL) isFormFilledOut;

@optional

-(void) setOldTag: (NSString*) oldTag;
-(NSString*) oldTag;
-(void) setCurrentTag: (NSString*) currentTag;
-(NSString*) currentTag;

@end
