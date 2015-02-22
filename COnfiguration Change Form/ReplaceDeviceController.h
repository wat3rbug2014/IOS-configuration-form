//
//  ChangeDeviceController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 9/24/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

/**
 * This ViewController is for the purposes of creating a form for replacing
 * equipment out in the field.  It will have the new equipment tag, old 
 * equipment tag, and the location information so this equipment can be
 * identified for the network map makers.
 */

#import "FormViewController.h"


@interface ReplaceDeviceController : FormViewController


/**
 * This field is for entering the tag number of the equipment that was removed
 * from service.
 */

@property (retain, nonatomic) IBOutlet UITextField *oldTag;


/**
 * This field is for entering the tag number of the equipment that has been placed
 * into service.
 */

@property (retain, nonatomic) IBOutlet UITextField *currentTag;


/**
 * This label is used for the fields for entering tags can be distinguished from
 * each other.  It represents the tag number indication for the equipment that has
 * been removed from service.
 */

@property (retain, nonatomic) IBOutlet UILabel *oldTagLabel;

@end
