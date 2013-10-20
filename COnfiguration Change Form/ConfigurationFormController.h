//
//  ConfigurationFormController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/20/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//
/* Create to enforce common naming for the subclasses of FormViewController */


#import <Foundation/Foundation.h>

@protocol ConfigurationFormController <NSObject>

-(id) initAsViewType: (int) typeType;

-(void) changeLabelColorForMissingInfo;
-(void) pushConnectionsController;
-(void) sendForm;
-(void) updateConfigurationDataStructure;
-(void) updateFormContents;

@end
