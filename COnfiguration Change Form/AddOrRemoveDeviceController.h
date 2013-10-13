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
#import "MailController.h"

@interface AddOrRemoveDeviceController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate>

@property BOOL isAddView;

@property (retain, nonatomic) IBOutlet UITextField *currentTag;
@property (retain, nonatomic) IBOutlet UILabel *tagLabel;
@property (retain, nonatomic) IBOutlet UITextField *buildingEntry;
@property (retain, nonatomic) IBOutlet UILabel *buildingLabel;
@property (retain, nonatomic) IBOutlet UITextField *closetEntry;
@property (retain, nonatomic) IBOutlet UILabel *closetLabel;
@property (retain, nonatomic) IBOutlet UILabel *equipTypeSelResult;
@property (retain, nonatomic) IBOutlet UIPickerView *deviceTypeSelection;
@property (retain, nonatomic) IBOutlet UILabel *equipTypeLabel;
@property (retain) PickerItems *devices;
@property (retain, nonatomic) ConfigurationData *data;
@property (nonatomic) NSInteger connectionsNeeded;


// custom methods

-(id) initAsViewType: (int) typeType;
-(void) sendForm;
-(void) changeLabelColorForMissingInfo;
-(void) updateConfigurationDataStructure;
-(void) pushConnectionsController;

@end
