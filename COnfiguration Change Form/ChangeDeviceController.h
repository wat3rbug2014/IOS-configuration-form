//
//  ChangeDeviceController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerItems.h"

@interface ChangeDeviceController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *deviceTypeSelResult;
@property (retain, nonatomic) IBOutlet UITextField *oldTag;
@property (retain, nonatomic) IBOutlet UITextField *currentTag;
@property (retain, nonatomic) IBOutlet UITextField *building;
@property (retain, nonatomic) IBOutlet UITextField *closet;
@property (retain) PickerItems *devices;
@property (retain, nonatomic) IBOutlet UIPickerView *deviceTypeSelection;

@end
