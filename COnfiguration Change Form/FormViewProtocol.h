//
//  FormViewProtocol.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/9/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//
/**
 * This protocol is used for conforming the view controllers so that they have
 * a common  API.
 */

#import <Foundation/Foundation.h>

@protocol FormViewProtocol <NSObject>


#pragma mark - Required methods


@required


/**
 * This method is used for highlighting the required fields of a particular form.  If overriding this
 * method, it is recommended to call this class method inside the subclass method for simplification
 * of code.
 */

-(void) changeLabelColorForMissingInfo;


/**
 * This method is used to save the data contents from the view.
 */

-(void) updateConfigurationDataStructure;


/**
 * This method is used to update the data model with information from the form fields.  This method should
 * be called in the overridden instances so that original information is also sent, for the sake of brevity.
 */

-(void) updateFormContents;


#pragma mark - Option methods


@optional


/**
 * This is an overridable method for the view controllers that need an additional viewcontroller
 * to be displayed for data entry.
 */

-(void) pushNextController;

@end
