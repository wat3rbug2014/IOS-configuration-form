//
//  FormViewController.h
//  COnfiguration Change Form
//
//  Created by Douglas Gardiner on 10/20/13.
//  Copyright (c) 2013 Douglas Gardiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PickerItems.h"
#import "ConfigurationData.h"
#import "ConfigurationFormController.h"

@interface FormViewController : UIViewController <ConfigurationFormController,UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate, UITextFieldDelegate>

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

-(id) initAsViewType: (NSInteger) typeType;

-(void) changeLabelColorForMissingInfo;
-(void) pushConnectionsController;
-(void) sendForm;
-(void) updateConfigurationDataStructure;
-(void) updateFormContents;

@end
