//
//  ChangeDeviceViewController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 11/5/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormViewController.h"

@interface AlterDeviceController : FormViewController

@property (retain, nonatomic) IBOutlet UITextField *oldTag;
@property (retain, nonatomic) IBOutlet UITextField *currentTag;
@property (retain, nonatomic) IBOutlet UILabel *oldTagLabel;

@end
