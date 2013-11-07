//
//  ChangeDeviceController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormViewController.h"

/* I should do something about this.  AddorRemoveController is the same as this controller except the xib... for the most part */

@interface ChangeDeviceController : FormViewController

@property (retain, nonatomic) IBOutlet UILabel *deviceTypeSelResult;
@property (retain, nonatomic) IBOutlet UITextField *oldTag;
@property (retain, nonatomic) IBOutlet UITextField *currentTag;
@property (retain, nonatomic) IBOutlet UITextField *buildingEntry;
@property (retain, nonatomic) IBOutlet UITextField *closetEntry;
@property (retain, nonatomic) IBOutlet UILabel *buildingLabel;
@property (retain, nonatomic) IBOutlet UILabel *closetLabel;
@property (retain, nonatomic) IBOutlet UILabel *currentTagLabel;
@property (retain, nonatomic) IBOutlet UILabel *oldTagLabel;
@property (retain, nonatomic) IBOutlet UILabel *equipTypeLabel;

@property (retain) PickerItems *devices;
@property (retain, nonatomic) IBOutlet UIPickerView *deviceTypeSelection;
@property (retain, nonatomic) ConfigurationData *data;
@property (nonatomic) NSInteger connectionsNeeded;

-(void) pushConnectionsController;
-(void) sendForm;
-(void) changeLabelColorForMissingInfo;
@end
