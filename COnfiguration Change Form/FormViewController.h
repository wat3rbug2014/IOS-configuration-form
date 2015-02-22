//
//  FormViewController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This is a generic super class for the subsequent view controller.  It is created 
 * because the generic ViewController class does not provide immediate support for 
 * several protocols that are in use for all the subsequent views that are used for 
 * this application.
 */

#import <UIKit/UIKit.h>
#import "PickerItems.h"
#import "ConfigurationDataProtocol.h"
#import "FormViewProtocol.h"

@interface FormViewController : UIViewController<UIPickerViewDelegate,
UIPickerViewDataSource,  UITextFieldDelegate, FormViewProtocol>


/**
 * The textfield that allows tag number entry for the application.
 */

@property (retain, nonatomic) IBOutlet UITextField *currentTag;


/**
 * Label for tag entry.  It is made accessible because some views change the label
 * to allow previous and current label entries.
 */

@property (retain, nonatomic) IBOutlet UILabel *currentTagLabel;


/**
 * The textfield that allows entry of the building number.
 */

@property (retain, nonatomic) IBOutlet UITextField *buildingEntry;


/**
 * The label that displays building so the text entry can be associated with it by
 * proximity.
 */

@property (retain, nonatomic) IBOutlet UILabel *buildingLabel;


/**
 * The textfield for closet entry.
 */

@property (retain, nonatomic) IBOutlet UITextField *closetEntry;


/**
 * The label that display closet so that adjacent textfield is related to it.
 */

@property (retain, nonatomic) IBOutlet UILabel *closetLabel;


/**
 * The label that displays the result of the device type selector.
 */

@property (retain, nonatomic) IBOutlet UILabel *deviceTypeSelResult;


/**
 * The pickerview that displays the list of devices to choose.
 */

@property (retain, nonatomic) IBOutlet UIPickerView *deviceTypeSelection;


/**
 * The label that is adjacent to the device type label to designate the displayed
 * result.
 */

@property (retain, nonatomic) IBOutlet UILabel *equipTypeLabel;


/**
 * The data structure that contains the contents for the UIPickerController for devices.
 */

@property (retain) PickerItems *devices;


/**
 * The data structure that contains all in the information needed to complete the updates for emailing
 * to the list in the user settings.  It conforms to the ConfigurationDataProtocol and is usually
 * a subclass of BasicDeviceData class.
 */

@property (retain, nonatomic) id<ConfigurationDataProtocol> data;


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
 * This is an overridable method for the view controllers that need an additional viewcontroller
 * to be displayed for data entry.
 */

-(void) pushNextController;


/**
 * This method is used to update the data model with information from the form fields.  This method should
 * be called in the overridden instances so that original information is also sent, for the sake of brevity.
 */

-(void) updateFormContents;

@end
