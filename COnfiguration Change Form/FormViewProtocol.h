//
//  FormViewProtocol.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/9/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FormViewProtocol <NSObject>

@required

-(void) changeLabelColorForMissingInfo;
-(void) updateConfigurationDataStructure;
-(void) updateFormContents;

@optional

-(void) pushNextController;

@end
