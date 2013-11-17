//
//  FormViewController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerItems.h"
#import "BasicDeviceData.h"
#import "FormViewProtocol.h"

@interface FormViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,  UITextFieldDelegate, FormViewProtocol>


@property (retain, nonatomic) IBOutlet UITextField *currentTag;
@property (retain, nonatomic) IBOutlet UILabel *currentTagLabel;
@property (retain, nonatomic) IBOutlet UITextField *buildingEntry;
@property (retain, nonatomic) IBOutlet UILabel *buildingLabel;
@property (retain, nonatomic) IBOutlet UITextField *closetEntry;
@property (retain, nonatomic) IBOutlet UILabel *closetLabel;
@property (retain, nonatomic) IBOutlet UILabel *deviceTypeSelResult;
@property (retain, nonatomic) IBOutlet UIPickerView *deviceTypeSelection;
@property (retain, nonatomic) IBOutlet UILabel *equipTypeLabel;
@property (retain) PickerItems *devices;
@property (retain, nonatomic) BasicDeviceData *data;

// custom methods

-(void) changeLabelColorForMissingInfo;
-(void) updateConfigurationDataStructure;
-(void) pushNextController;
-(void) updateFormContents;

@end
