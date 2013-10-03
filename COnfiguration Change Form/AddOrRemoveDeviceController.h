//
//  AddOrRemoveDeviceController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerItems.h"
#import "ConfigurationData.h"

@interface AddOrRemoveDeviceController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property BOOL isAddView;

@property (retain, nonatomic) IBOutlet UITextField *tagEntry;
@property (retain, nonatomic) IBOutlet UITextField *buildingEntry;
@property (retain, nonatomic) IBOutlet UITextField *closetEntry;
@property (retain, nonatomic) IBOutlet UILabel *tagLabel;
@property (retain, nonatomic) IBOutlet UILabel *equipTypeSelResult;
@property (retain, nonatomic) IBOutlet UIPickerView *deviceTypeSelection;
@property (retain) PickerItems *devices;
@property (retain, nonatomic) ConfigurationData *data;

-(id) initAsAddView: (BOOL) isAddView;

@end
